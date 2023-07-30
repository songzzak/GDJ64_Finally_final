package com.workit.chat.model.service;

import java.util.List;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;

public interface ChatService {
	List<MyChatroom> selectMyChatroomById(String memberId);
	List<Chat> selectChatroom(String chatroomId);
	List<MyChatroom> searchAllByKeyword(String keyword);
 }
