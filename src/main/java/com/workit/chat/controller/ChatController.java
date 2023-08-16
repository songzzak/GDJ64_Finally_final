package com.workit.chat.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.service.ChatService;
import com.workit.chatroom.model.dto.ChatNotificationVO;
import com.workit.chatroom.service.ChatroomService;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;



@Controller
@RequestMapping("/chat")
@Slf4j
public class ChatController {
	
	private ChatService chatService;
	private ChatroomService chatroomService;
	
	public ChatController(ChatService chatService, ChatroomService chatroomService) {
		this.chatService = chatService;
		this.chatroomService = chatroomService;
	}
	
	@RequestMapping("/")
	public String selectMyChatroomById(Model model, HttpSession session){
		MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
		Map<String, Object> param = chatService.selectMyChatroomList(loginMember.getMemberId());
		model.addAttribute("chat",param.get("chat"));
		model.addAttribute("myChatroomList",param.get("myChatroomList"));
		model.addAttribute("members", param.get("members"));
		model.addAttribute("dept",param.get("dept"));
		model.addAttribute("unreadMap", param.get("unreadMap"));
		log.info("unreadMap : " + param.get("unreadMap"));
		return "/chat/chat";
	}
	
	@PostMapping("/chatroom/{chatroomId}")
	@ResponseBody
	public ResponseEntity<?> selectChatroom(@RequestParam(value="chatroomId")String chatroomId, @RequestParam int myChatroomNo, HttpSession session, Model model) {
		Map<String, Object> result = chatService.selectChatroomByroomId(chatroomId);
		int delResult = chatroomService.deleteNotify(myChatroomNo);
		log.info("delResult : " + delResult);
		if(delResult>0) {
			ChatNotificationVO c = ChatNotificationVO.builder().myChatroomNo(myChatroomNo).readCount(0).build();
			model.addAttribute("unreadMap",c);
			result.put("readCount", c);
		}
		log.info("chatroom result");
		log.info("{}", result.get("chatroomList"));
		
		return ResponseEntity.ok().body(result);
	}
	
	
	@PostMapping("/keyword")
	@ResponseBody
	public ResponseEntity<?> searchAllByKeyword(@RequestParam(value="keyword")String keyword, Model model){
		log.info("{}", keyword);
		log.info("{}", chatService.searchByKeyword(Map.of("keyword",keyword)));
		return ResponseEntity.ok().body(chatService.searchByKeyword(Map.of("keyword",keyword)));
	}
	
	
	// 채팅 생성을 위한 전체 회원 조회
	@PostMapping("/dept")
	@ResponseBody
	public List<Member> selectMember(){
		log.info("{}", chatService.selectMemberAll());
		return chatService.selectMemberAll();
	}
	
	
	@PostMapping("/insert")
	@ResponseBody
	public ResponseEntity<?> insert(@RequestBody Chatroom chatroom, HttpSession session, Model model) {
		MemberVO m = (MemberVO)session.getAttribute("loginMember");
		String loginMember = m.getMemberId();
		log.info("{}", chatroom);
		String chatroomId = chatService.insertChatroom(loginMember, chatroom);
		@SuppressWarnings("unchecked")
		List<MyChatroom> chatroomMembers = (List<MyChatroom>) chatService.selectChatroomByroomId(chatroomId).get("chatroomMember");
		model.addAttribute("chatroomMembers", chatroomMembers);
	    return ResponseEntity.ok().body(chatroomMembers);
	}
	
	@DeleteMapping("/delete")
	@ResponseBody
	public int deleteMyChatroom(@RequestParam(value="chatroomId")String chatroomId, @RequestParam(value="loginMember")String loginMember) {
		return chatService.deleteMyChatroom(Map.of("chatroomId",chatroomId, "loginMember",loginMember));
	}
	
	@PostMapping("/member")
	@ResponseBody
	public List<Member> selectChatMemberById(@RequestParam(value="chatroomId")String chatroomId){
		return chatService.selectMemberAll();
	}
	
	@PostMapping("/notify")
	@ResponseBody
	public int chatNotificationCount(@RequestParam String memberId) {
		return chatroomService.chatNotificationCount(memberId);
	}
	
}
