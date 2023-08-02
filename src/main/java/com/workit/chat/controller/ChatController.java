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
		String memberId = loginMember.getMemberId();
		model.addAttribute("chatroomList",service.selectMyChatroomById(memberId));
		return "/chat/chat";
	}
	
	// 선택한 채팅창 보여주기
//	@PostMapping("/chatroom")
//	public String selectChatroom(Map<String, Object> param, String chatroomId, Model model) {
//		log.info("{}", chatroomId);
//		log.info("{}", service.selectChatroomByroomId(chatroomId));
//		model.addAttribute("chatroom", service.selectChatroomByroomId(chatroomId));
//		return "/chat/chat";
//	}
	
	@PostMapping("/chatroom")
	@ResponseBody
	public List<MyChatroom> selectChatroom(Map<String, Object> param, String chatroomId) {
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
	@GetMapping("/chatting")
	public String startChat() {
		return "/chat/chat";
	}
	
	// 채팅 생성
	@PostMapping("/insertChat")
	public String insertChat(@RequestParam(value="chatroomTitle")String chatroomTitle, @RequestParam(value="memberId")String memberId, Model model, HttpSession session) {
		
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
		
		List<MyChatroom> list = service.insertChat(param);
		log.info("{}", list);
		if(list!=null) {
			model.addAttribute("chatroom",list);
			return "chat/chat";
		}else {
			model.addAttribute("msg","생성 실패");
			model.addAttribute("url","/chat/");
			return "common/msg";
		}
	}
	
	// 채팅 나가기 
	@DeleteMapping("/delete")
	public String deleteMyChatroom(@RequestParam(value="chatroomId")String chatroomId, HttpSession session) {
		log.info("{}", chatroomId);
		Member member = (Member)session.getAttribute("loginMember");
		String loginMember = member.getMemberId();
		//int result = service.deleteMyChatroom(chatroomId, loginMember);
		return "common/msg";
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
