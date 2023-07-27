package com.workit.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	
	
}
