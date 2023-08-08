package com.workit.chat.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dto.Attachment;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.model.service.ChatService;
import com.workit.employee.service.EmployeeService;
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
	
	@RequestMapping("/")
	public String selectMyChatroomById(Model model, HttpSession session){
		Member loginMember = (Member)session.getAttribute("loginMember");
		Map<String, Object> param = service.selectMyChatroomList(loginMember.getMemberId());
		model.addAttribute("chat",param.get("chat"));
		model.addAttribute("roomNumbers",param.get("roomNumbers"));
		model.addAttribute("members", param.get("members"));
		model.addAttribute("dept",param.get("dept"));
		return "/chat/chat";
	}
	
	@GetMapping("/chatroom")
	@ResponseBody
	public Map<String, Object> selectChatroom(@RequestParam(value="chatroomId")String chatroomId, HttpSession session, Model model) {
//		log.info("chatroom start");
//		log.info("{}", chatroomId);
		Map<String, Object> result = service.selectChatroomByroomId(chatroomId);
		List<MyChatroom> chatroomMembers =(List<MyChatroom>) result.get("chatroomMember");
		model.addAttribute("chatroomMembers",chatroomMembers);
//		log.info("chatroommember");
//		log.info("{}", chatroomMembers);
		return result;
	}
	
	@PostMapping("/keyword")
	@ResponseBody
	public List<MyChatroom> searchAllByKeyword(@RequestParam(value="keyword")String keyword, Model model){
		log.info("{}", keyword);
		log.info("{}", service.searchAllByKeyword(keyword));
		//model.addAttribute("result",service.searchAllByKeyword(keyword));
		return service.searchAllByKeyword(keyword);
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String updateChatroomMember(@RequestParam(value="memberId")String memberId, HttpSession session, Model model) {
		log.info("update");
		log.info("{}", memberId);
		String chatroomId = (String)session.getAttribute("chatroomId");
		String msg, loc;
		if(service.updateChatroomMember(Map.of("member",memberId,"chatroomId",chatroomId))>0) {
			model.addAttribute("msg", "채팅 멤버 추가 성공 :)");
			model.addAttribute("loc", "/chat/chat");
		}else {
			model.addAttribute("msg", "채팅 멤버 추가 실패 :<");
			model.addAttribute("loc", "/chat/chat");
		}
		return "common/msg";
	}
	
	// 채팅 생성을 위한 전체 회원 조회
	@PostMapping("/dept")
	@ResponseBody
	public List<Member> selectMember(){
		log.info("{}", service.selectMemberAll());
		return service.selectMemberAll();
	}
	
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
	
	@PostMapping("/insert")
	@ResponseBody
	public Map<String, Object> insert(@RequestBody Chatroom chatroom, HttpSession session, Model model) {
		//log.info("{}", chatroom);
		Member m = (Member)session.getAttribute("loginMember");
		String loginMember = m.getMemberId();
		String chatroomId = service.insertChatroom(loginMember, chatroom);
//		log.info("{}",chatroomId);
//		log.info("{}",service.selectChatroomByroomId(chatroomId));
		List<MyChatroom> chatroomMembers =(List<MyChatroom>) service.selectChatroomByroomId(chatroomId).get("chatroomMember");
		model.addAttribute("chatroomMembers",chatroomMembers);
		
		return service.selectChatroomByroomId(chatroomId);
	}
	
	@DeleteMapping("/delete")
	@ResponseBody
	public int deleteMyChatroom(@RequestParam(value="chatroomId")String chatroomId, @RequestParam(value="loginMember")String loginMember) {
		//log.info("{}", chatroomId);
//		Member member = (Member)session.getAttribute("loginMember");
//		String loginMember = member.getMemberId();
		return service.deleteMyChatroom(Map.of("chatroomId",chatroomId, "loginMember",loginMember));
	}
	
	@PostMapping("/member")
	@ResponseBody
	public List<Member> selectChatMemberById(@RequestParam(value="chatroomId")String chatroomId){
		return service.selectMemberAll();
	}
	
	// 파일 업로드 
	@RequestMapping("/attach")
	public String upFile(MultipartFile [] uploadFile, HttpSession session, Model m, Chatroom ch) {
		log.info("{}", uploadFile);
		
		//MultipartFile에서 제공하는 메소드를 이용해서 
		//파일을 저장할 수 있음 -> transferTo()메소드를 이용
		//절대경로 가져오기
		String path=session.getServletContext().getRealPath("/resources/upload/chat/");
		//파일명에 대한 renamed규칙을 설정
		//직접리네임규칙을 만들어서 저장해보자.
		//yyyyMMdd_HHmmssSSS_랜덤값
		log.info("{}", path);
		List<Attachment> files=new ArrayList<Attachment>();
		log.info("{}", files);
		if(uploadFile!=null) {
			for(MultipartFile mf:uploadFile) {
				if(!mf.isEmpty()) {
					String oriName=mf.getOriginalFilename();
					log.info("{}", oriName);
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
							.uploadPath(path)
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
		
		return "chat/chat";
	}
	
}
