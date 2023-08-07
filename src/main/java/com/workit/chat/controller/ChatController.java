package com.workit.chat.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dto.Attachment;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.model.service.ChatService;
import com.workit.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;



@Controller
@RequestMapping("/chat")
@Slf4j
public class ChatController {
	
	private ChatService service;
	
	public ChatController(ChatService service) {
		this.service = service;
	}
	
	// 전체 채팅창 목록
	@RequestMapping("/")
	public String selectMyChatroomById(Model model, HttpSession session){
		Member loginMember = (Member)session.getAttribute("loginMember");
		Map<String, Object> param = service.selectMyChatroomList(loginMember.getMemberId());
		model.addAttribute("chat",param.get("chat"));
		model.addAttribute("roomNumbers",param.get("roomNumbers"));
		return "/chat/chat";
	}
	
	// 선택한 채팅창 보여주기
//	@GetMapping("/chatroom")
//	public String selectChatroom(@RequestParam(value="chatroomId")String chatroomId, Model model, HttpSession session) {
//		log.info("{}", chatroomId);
//		log.info("{}", service.selectChatByChatroomId(chatroomId));
//		Member loginMember = (Member)session.getAttribute("loginMember");
//		String memberId = loginMember.getMemberId();
//		model.addAttribute("chatroomList",service.selectMyChatroomById(memberId));
//		model.addAttribute("chatroom", service.selectChatByChatroomId(chatroomId));
//		return "/chat/chat";
//	}
	
	@GetMapping("/chatroom")
	@ResponseBody
	public List<MyChatroom> selectChatroom(Map<String, Object> param, @RequestParam(value="chatroomId")String chatroomId,HttpSession session, Model model) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		model.addAttribute("chatroomList",service.selectMyChatroomById(memberId));
		model.addAttribute("chatroomId",chatroomId);
		session.setAttribute("chatroomId", chatroomId);
		log.info("{}", chatroomId);
		log.info("{}", service.selectChatroomByroomId(chatroomId));
		return service.selectChatroomByroomId(chatroomId);
	}
	
	// 키워드로 검색
	@PostMapping("/keyword")
	@ResponseBody
	public String searchAllByKeyword(@RequestParam(value="keyword")String keyword, Model model){
		model.addAttribute("result",service.searchAllByKeyword(keyword));
		log.info("{}", service.searchAllByKeyword(keyword));
		return "chat/chat";
	}
	
	// 채팅 생성을 위한 전체 회원 조회
	@PostMapping("/dept")
	@ResponseBody
	public List<Member> selectMember(){
		log.info("{}", service.selectMemberAll());
		return service.selectMemberAll();
	}
	
	// 채팅 웹소켓
//	@GetMapping("/start")
//	public String startChat() {
//		return "/chat/chattingpage";
//	}
	@GetMapping("/chatting")
	public String startChat() {
		return "/chat/chat";
	}
	
	@PostMapping("/search")
	@ResponseBody
	public String searchChatroomByKeyword(@RequestParam(value="chatroomId")String chatroomId, @RequestParam(value="keyword")String keyword) {
		service.searchChatroomByKeyword(Map.of("chatroomId",chatroomId, "keyword",keyword));
		return "chat/chatroom";
	}
	
	// 채팅 생성
	@PostMapping("/start")
	public String insertChatroom(@RequestParam(value="chatroomTitle")String chatroomTitle, @RequestParam(value="memberId")String memberId, Model model, HttpSession session) {
		
		String chatroomCode="";
		String[] member = null;
		Member m = (Member)session.getAttribute("loginMember");
		String loginMember = m.getMemberId();
		member = memberId.split(",");
		
		if(member.length>1) {
			chatroomCode="G";
		}else {
			chatroomCode="P";
		}
		if(chatroomTitle == null || chatroomTitle =="") {
			chatroomTitle = memberId+"("+member.length+")";
		}
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("chatroomTitle", chatroomTitle);
		param.put("chatroomCode", chatroomCode);
		param.put("loginMember",loginMember);
		param.put("member", member);
		
		String chatroomId = service.insertChatroom(param);
		model.addAttribute("chatroomId",chatroomId);
		return "chat/chat";
	}
	
	// 채팅 나가기 
	@DeleteMapping("/delete")
	@ResponseBody
	public int deleteMyChatroom(@RequestParam(value="chatroomId")String chatroomId, @RequestParam(value="loginMember")String loginMember) {
		log.info("{}", chatroomId);
//		Member member = (Member)session.getAttribute("loginMember");
//		String loginMember = member.getMemberId();
		return service.deleteMyChatroom(Map.of("chatroomId",chatroomId, "loginMember",loginMember));
	}
	
	// 파일 업로드 
	@RequestMapping("/attatch")
	public String upFile(Chat c, MultipartFile [] upFile, HttpSession session, Model m, Chatroom ch) {
		log.info("{}", c);
		log.info("{}", upFile);
		
		//MultipartFile에서 제공하는 메소드를 이용해서 
		//파일을 저장할 수 있음 -> transferTo()메소드를 이용
		//절대경로 가져오기
		String path=session.getServletContext().getRealPath("/resources/upload/chat/");
		//파일명에 대한 renamed규칙을 설정
		//직접리네임규칙을 만들어서 저장해보자.
		//yyyyMMdd_HHmmssSSS_랜덤값
//		List<Attachment> files=new ArrayList();
		if(upFile!=null) {
			for(MultipartFile mf:upFile) {
				if(!mf.isEmpty()) {
					String oriName=mf.getOriginalFilename();
					String ext=oriName.substring(oriName.lastIndexOf("."));
					Date today=new Date(System.currentTimeMillis());
					SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rdn=(int)(Math.random()*10000)+1;
					String rename=sdf.format(today)+"_"+rdn+ext;
					
					try {
						mf.transferTo(new File(path+rename));
					}catch(IOException e) {
						e.printStackTrace();
					}
					
					Attachment file=Attachment.builder()
							.originalFile(oriName)
							.renameFile(rename)
							.build();
					
					//ch.getFile().add(file);
				}
			}
		}
//		try {
//			//service.insertBoard(c);
//		}catch(RuntimeException e) {
//			for(Attachment a : ch.getFile()) {
//				File delFile=new File(path+a.getRenameFile());
//				delFile.delete();
//			}
//			m.addAttribute("msg","글쓰기 등록실패! :P");
//			m.addAttribute("loc", "/board/boardForm.do");
//			return "common/msg";
//		}
		
		
		
		return "redirect:/board/boardList.do";
	}
	
}
