package com.workit.chat.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chat.model.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ChatServer extends TextWebSocketHandler {
	
	private ChatService service;
	private ObjectMapper mapper;
	
	public ChatServer(ChatService service, ObjectMapper mapper) {
		this.service = service;
		this.mapper = mapper;
	}
	
	private Map<String,WebSocketSession> clients = new HashMap<String, WebSocketSession>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("{}","접속");
		log.info("{}",session.getId());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}",message.getPayload());
		Chat chat =mapper.readValue(message.getPayload(),Chat.class);
		session.getAttributes().put("chat", chat);
		log.info("{}", chat);
		int result = service.insertChat(chat);
		if(result>0) {
			//성공
			log.info("{}","성공");
			sendChat(chat);
			log.info("{}",service.selectChatMember(chat.getChatroomId()));
			List<MyChatroom> chatMembers = service.selectChatMember(chat.getChatroomId());
			chattingMember(chatMembers);
		}else {
			// fail z
		}
	}
	private Map<String, Object> members= null;
	
	private void chattingMember(List<MyChatroom> chatMembers) {
		log.info("{}", chatMembers);
		for(MyChatroom m : chatMembers) {
			log.info("{}",m.getMember().getMemberId());
		}
	}
	
	private void sendChat(Chat chat) {
//		Set<Map.Entry<String,WebSocketSession>> clients=this.clients.entrySet();
//		try {
//			for(Map.Entry<String,WebSocketSession> client:clients) {
//				String userId=client.getKey();
//				log.info("{}", userId);
//				client.getValue().sendMessage(
//						new TextMessage(mapper.writeValueAsString(chat))
//						);
//				log.info("{}", client.getValue());
//			}
//		}catch(IOException e){
//			e.printStackTrace();
//		}
	}
	
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("{}","접속 끝 ;<");
	}
}