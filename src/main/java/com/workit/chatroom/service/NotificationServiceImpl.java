package com.workit.chatroom.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.chat.websocket.MyWebSocketHandler;

@Service
public class NotificationServiceImpl implements NotificationService {
	
	@Autowired
    private MyWebSocketHandler webSocketHandler;

    public void sendNotificationToUser(String userId, String message) {
//        try {
//            // 해당 유저에게 실시간 알림을 보내는 메소드 호출
//           // webSocketHandler.sendNotificationToUser(userId, message);
//        } catch (IOException e) {
//            // 예외 처리
//        }
    }
}
