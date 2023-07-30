package com.workit.chat.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dto.Attachment;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.model.service.ChatService;

import lombok.extern.slf4j.Slf4j;



@Controller
@RequestMapping("/chat")
@Slf4j
public class ChatController {
	
	private ChatService service;
	
	public ChatController(ChatService service) {
		this.service = service;
	}
	
	
	// 채팅 페이지 이동
	@RequestMapping("/")
	public String selectMyChatroomById(Model m){
		return "/chat/chat";
	}
	
	// 전체 채팅 목록 - 마지막으로 보낸 안 읽은 메세지가 있는 순으로 출력
	@PostMapping("/")
	@ResponseBody
	public List<MyChatroom> selectMyChatroomById(){
		String memberId="2023072796";
		log.info("{}",service.selectMyChatroomById(memberId));
		return service.selectMyChatroomById(memberId);
		
	}
	// 선택한 채팅창 보여주기
	@PostMapping("/chatroom")
	@ResponseBody
	public List<Chat> selectChatroom(Map<String, Object> param, String chatroomId) {
		log.info("{}", chatroomId);
		log.info("{}", service.selectChatroom(chatroomId));
		return service.selectChatroom(chatroomId);
	}
	
	// 
	@PostMapping("/keyword")
	@ResponseBody
	public List<MyChatroom> searchAllByKeyword(String keyword){	
		return service.searchAllByKeyword(keyword);
		
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
