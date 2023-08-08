package com.workit.chat.model.dao;

import org.springframework.stereotype.Repository;

import com.workit.chat.mapper.ChatMapper;
import com.workit.chat.model.dto.ChatMsg;
@Repository
public class ChatMsgDaoImpl implements ChatMsgDao {

	private ChatMapper chatMapper;
	
	public ChatMsgDaoImpl(ChatMapper chatMapper) {
		this.chatMapper = chatMapper;
	}
	
	
	@Override
	public int insertChat(ChatMsg chat) {
		return chatMapper.insertChat(chat);
	}
	
}
