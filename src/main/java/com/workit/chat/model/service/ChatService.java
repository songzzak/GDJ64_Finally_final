package com.workit.chat.model.service;

import java.util.List;

import com.workit.chat.model.dto.Chatroom;

public interface ChatService {
	List<Chatroom> selectChatroomAll();
}
