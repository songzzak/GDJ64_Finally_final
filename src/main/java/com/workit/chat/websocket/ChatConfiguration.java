package com.workit.chat.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class ChatConfiguration implements WebMvcConfigurer, WebSocketConfigurer {
	
	private ChatServer chatServer;
	
	public ChatConfiguration(ChatServer chatServer) {
		this.chatServer = chatServer;
	}

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(chatServer, "/chatting");
	}
	
//	@Override
//	public void addViewControllers(ViewControllerRegistry registry) {
//		registry.addViewController("/chattingpage").setViewName("chattingpage");
//	}
	
}
