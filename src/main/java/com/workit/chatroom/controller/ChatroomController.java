package com.workit.chatroom.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.service.ChatroomService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chatroom")
public class ChatroomController {
	
	private ChatroomService chatroomService;
	
	public ChatroomController(ChatroomService chatroomService) {
		this.chatroomService = chatroomService;
	}
	
	@PostMapping("/upload")
    public String uploadFile(@RequestParam("uploadFile") List<MultipartFile> files, @RequestParam(value="chatroomId") String chatroomId) throws IOException {
		log.info("{}", chatroomId);
		List<AttachedFile> fileList = new ArrayList<AttachedFile>();
		if(files!=null && files.size()>0) {
			for (MultipartFile multipartFile : files) {
				log.info("{}", multipartFile.getOriginalFilename());
				AttachedFile uploadFile = chatroomService.saveFile(multipartFile, chatroomId);
				if(uploadFile==null) return "fail";
			}
		}
        return "/chat/";
    }
}
