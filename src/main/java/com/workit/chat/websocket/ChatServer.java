package com.workit.chat.websocket;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@ServerEndpoint(value="/chat/chatting")
@Slf4j
public class ChatServer {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnMessage
	//클라이언트로부터 메시지가 전달되면 WebSocketChatt 클래스의 onMessage메서드에 의해  clients에 있는 모든 session에 메시지를 전달합니다.
	public void onMessage(String msg, Session session) throws Exception{
		
	}
	
	@OnOpen
	//클라이언트가 ServerEndpoint값인 “/chat “ url로 서버에 접속하게 되면 onOpen 메서드가 실행되며, 
	//클라이언트 정보를 매개변수인 Session 객체를 통해 전달받습니다. 
	//이때 정적 필드인 clients에 해당 session이 존재하지 않으면 clients에 접속된 클라이언트를 추가합니다.
	public void onOpen(Session s) {
		log.info("접속");
	}
	
	@OnClose
	//클라이언트가 url을 바꾸거나 브라우저를 종료하면 자동으로 onClose() 메서드가 실행되며 해당 클라이언트 정보를 clients에서 제거합니다.
	public void onClose(Session s) {

	}
	
}
