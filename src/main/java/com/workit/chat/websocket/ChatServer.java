package com.workit.chat.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chat.service.ChatService;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.service.ChatroomService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ChatServer extends TextWebSocketHandler {
	
	private ChatService chatService;
	private ChatroomService chatroomService;
	private ObjectMapper mapper;
	
	public ChatServer(ChatService chatService, ChatroomService chatroomService, ObjectMapper mapper) {
		this.chatService = chatService;
		this.chatroomService = chatroomService;
		this.mapper = mapper;
	}
	// root 경로
	private final String path = System.getProperty("user.dir");
	// 루트 경로에 있는 file directory
	//private final String fileDir = path + "/webapp/resources/upload/chat/";
	
	private Map<String,WebSocketSession> clients = new HashMap<String, WebSocketSession>();
	private String chatroomId;
	
	//private String path2=ChatServer.class.getResource("/").getPath();
			
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("{}","접속");
		log.info("path");
//		path2 = path2.substring(0,path2.lastIndexOf("target"))+"/src";
//		log.info(path2);
		log.info(session.getId()+" "+session.getRemoteAddress());
		clients.put(session.getId(), session);
		
		String url = session.getUri().toString();
		log.info("{}", url);
		chatroomId = url.split("/chating/")[1];
		
		
	}
	
//	private static JSONObject JsonToObjectParser(String jsonStr) {
//		JSONParser parser = new JSONParser();
//		JSONObject obj = null;
//		try {
//			obj = (JSONObject) parser.parse(jsonStr);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		return obj;
//	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String msg = message.getPayload();
		log.info("{}",msg);
		
		ChatMsg chat =mapper.readValue(message.getPayload(),ChatMsg.class);
		
		if(chat.getChatId()==null || chat.getChatId()=="") {
			session.getAttributes().put("chat", chat);
			sendChat(chat);
		}
		else if(chat!=null && chat.getChatId()!=null) {
			log.info("chat 전송");
			session.getAttributes().put("chat", chat);
			log.info("{}", chat);
			int result = chatroomService.insertChat(chat);
			log.info("{}", result);
			if(result>0) {
				log.info("{}","성공");
				log.info("{}",chatService.selectChatMember(chat.getChatroomId()));
//				String sender = chat.getMemberId();
//				clients.put(sender, session);
//				log.info("sender");
//				log.info("{}", sender);
//				log.info("현재접속자 : "+clients.size());
				sendChat(chat);
			}else {
				
			}
		}
	}
	
	
	//private void sendFile(String fileName) {
//	private void sendFile(AttachedFile file) {
//		log.info("send file method");
//		log.info("{}", file);
//		Set<Map.Entry<String,WebSocketSession>> clients=this.clients.entrySet();
//		log.info("{}", clients);
//		try {
//			for(Map.Entry<String,WebSocketSession> client:clients) {
//				// session에 보낸 사람을 저장하지 않아서 오지 않았다
//				String userId=client.getKey();
//				log.info("{}", userId);
//				client.getValue().sendMessage(new TextMessage(mapper.writeValueAsString(file)));
//				//client.getValue().sendMessage(new TextMessage("asdgsadg"));
//			}
//		}catch(IOException e){
//			e.printStackTrace();
//		}
//	}
	
	private void sendChat(ChatMsg chat) {
		log.info("send Chat method");
		Set<Map.Entry<String,WebSocketSession>> clients=this.clients.entrySet();
		try {
			for(Map.Entry<String,WebSocketSession> client:clients) {
				String userId=client.getKey();
				log.info("{}", userId);
				client.getValue().sendMessage(new TextMessage(mapper.writeValueAsString(chat)));
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
