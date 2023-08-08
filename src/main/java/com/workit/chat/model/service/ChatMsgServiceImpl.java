package com.workit.chat.model.service;


import org.springframework.stereotype.Service;

import com.workit.chat.model.dao.ChatDao;
import com.workit.chat.model.dao.ChatMsgDao;
import com.workit.chat.model.dto.ChatMsg;

@Service
public class ChatMsgServiceImpl implements ChatMsgService {
	
	private ChatDao chatDao;
	private ChatMsgDao msgDao;
	public ChatMsgServiceImpl(ChatDao chatDao, ChatMsgDao msgDao) {
		this.chatDao = chatDao;
		this.msgDao = msgDao;
	}
	
	@Override
	public int insertChat(ChatMsg chat) {
		return msgDao.insertChat(chat);
	}
	
}
