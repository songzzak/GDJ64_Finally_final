package com.workit.chat.controller;

import java.io.IOException;
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

import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.service.ChatService;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatroomFile;
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
		model.addAttribute("roomNumbers",param.get("roomNumbers"));
		model.addAttribute("members", param.get("members"));
		model.addAttribute("dept",param.get("dept"));
		return "/chat/chat";
	}
	
	@GetMapping("/chatroom/{chatroomId}")
	@ResponseBody
	public Map<String, Object> selectChatroom(@RequestParam(value="chatroomId")String chatroomId, HttpSession session, Model model) {
//		log.info("chatroom start");
//		log.info("{}", chatroomId);
		Map<String, Object> result = chatService.selectChatroomByroomId(chatroomId);
//		List<MyChatroom> chatroomMembers =(List<MyChatroom>) result.get("chatroomMember");
//		model.addAttribute("chatroomMembers",chatroomMembers);
		log.info("chatroom result");
		log.info("{}", result.get("chatroomList"));
		return result;
	}
	
    public String uploadFile(@RequestParam("uploadFile") List<MultipartFile> files, @RequestParam(value="chatroomId") String chatroomId) throws IOException {
		log.info("{}", chatroomId);
		if(files!=null && files.size()>0) {
			for (MultipartFile multipartFile : files) {
				log.info("{}", multipartFile.getOriginalFilename());
				AttachedFile uploadFile = chatroomService.saveFile(multipartFile, chatroomId);
				if(uploadFile==null) return "fail";
			}
		}
        return "/chat/chatroom/"+chatroomId;
    }
	
	
	@PostMapping("/keyword")
	@ResponseBody
	public List<MyChatroom> searchAllByKeyword(@RequestParam(value="keyword")String keyword, Model model){
		log.info("{}", keyword);
		log.info("{}", chatService.searchAllByKeyword(keyword));
		//model.addAttribute("result",service.searchAllByKeyword(keyword));
		return chatService.searchAllByKeyword(keyword);
	}
	
	@PostMapping("/update")
	@ResponseBody
	public int updateChatroomMember(@RequestParam(value="chatMember")String chatMember, @RequestParam(value="chatroomId") String chatroomId, HttpSession session, Model model) {
		return chatService.updateChatroomMember(Map.of("member",chatMember,"chatroomId",chatroomId));
	}
	
	// 채팅 생성을 위한 전체 회원 조회
	@PostMapping("/dept")
	@ResponseBody
	public List<Member> selectMember(){
		log.info("{}", chatService.selectMemberAll());
		return chatService.selectMemberAll();
	}
	
	@GetMapping("/chatting")
	public String startChat() {
		return "/chat/chat";
	}
	
	@PostMapping("/search")
	@ResponseBody
	public String searchChatroomByKeyword(@RequestParam(value="chatroomId")String chatroomId, @RequestParam(value="keyword")String keyword) {
		chatService.searchChatroomByKeyword(Map.of("chatroomId",chatroomId, "keyword",keyword));
		return "chat/chatroom";
	}
	
	@PostMapping("/insert")
	@ResponseBody
	 //multipart/form- data는 이렇게 받기
	//public Map<String, Object> insert(@ModelAttribute Chatroom chatroom, HttpSession session, Model model) {
	public Map<String, Object> insert(@RequestBody Chatroom chatroom, HttpSession session, Model model) {
		MemberVO m = (MemberVO)session.getAttribute("loginMember");
		String loginMember = m.getMemberId();
		log.info("{}", chatroom);
		String chatroomId = chatService.insertChatroom(loginMember, chatroom);
//		log.info("{}",chatroomId);
//		log.info("{}",service.selectChatroomByroomId(chatroomId));
		List<MyChatroom> chatroomMembers =(List<MyChatroom>) chatService.selectChatroomByroomId(chatroomId).get("chatroomMember");
		model.addAttribute("chatroomMembers",chatroomMembers);
		
		return chatService.selectChatroomByroomId(chatroomId);
	}
	
	@DeleteMapping("/delete")
	@ResponseBody
	public int deleteMyChatroom(@RequestParam(value="chatroomId")String chatroomId, @RequestParam(value="loginMember")String loginMember) {
		//log.info("{}", chatroomId);
//		Member member = (Member)session.getAttribute("loginMember");
//		String loginMember = member.getMemberId();
		return chatService.deleteMyChatroom(Map.of("chatroomId",chatroomId, "loginMember",loginMember));
	}
	
	@PostMapping("/member")
	@ResponseBody
	public List<Member> selectChatMemberById(@RequestParam(value="chatroomId")String chatroomId){
		return chatService.selectMemberAll();
	}
	
	// 파일 업로드 
//	@RequestMapping("/attach")
//	public String upFile(MultipartFile [] uploadFile, HttpSession session, Model m, Chatroom ch) {
//		return "chat/chat";
//	}
	
	@PostMapping("/file")
	public List<ChatroomFile> selectFileByRoomId(@RequestParam("chatroomId")String chatroomId){
		log.info("{}", chatroomId);
		return chatroomService.selectFileByChatroomId(chatroomId); 
	}
	
	
}
