package com.workit.chat.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chat.model.service.ChatMsgService;
import com.workit.chat.model.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ChatServer extends TextWebSocketHandler {
	
	private ChatService chatService;
	private ChatMsgService chatMsgService;
	private ObjectMapper mapper;
	
	public ChatServer(ChatService chatService, ChatMsgService chatMsgService, ObjectMapper mapper) {
		this.chatService = chatService;
		this.chatMsgService = chatMsgService;
		this.mapper = mapper;
	}
	
	private Map<String,WebSocketSession> clients = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("{}","접속");
		log.info(session.getId()+" "+session.getRemoteAddress());
	}
	

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}",message.getPayload());
		
		ChatMsg chat =mapper.readValue(message.getPayload(),ChatMsg.class);
		session.getAttributes().put("chat", chat);
		log.info("{}", chat);
		int result = chatMsgService.insertChat(chat);
		if(result>0) {
			log.info("{}","성공");
			log.info("{}",chatService.selectChatMember(chat.getChatroomId()));
			String sender = chat.getMemberId();
			clients.put(sender, session);
			log.info("sender");
			log.info("{}", sender);
			log.info("현재접속자 : "+clients.size());
			sendChat(chat);
		}else {
		}
	}
	
	private void sendChat(ChatMsg chat) {
		log.info("send Chat method");
		Set<Map.Entry<String,WebSocketSession>> clients=this.clients.entrySet();
		try {
			for(Map.Entry<String,WebSocketSession> client:clients) {
				String userId=client.getKey();
				log.info("{}", userId);
				client.getValue().sendMessage(new TextMessage(mapper.writeValueAsString(chat)));
				log.info("{}", client.getValue());
			}
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("{}","접속 끝 ;<");
	}
}
