package com.workit.chat.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.workit.chat.model.dao.ChatDao;
import com.workit.chat.model.dto.Chatroom;
@Service
public class ChatServiceImpl implements ChatService {
	
	private SqlSession session;
	private ChatDao dao;
	public ChatServiceImpl(SqlSession session, ChatDao dao) {
		this.session = session;
		this.dao = dao;
	}
	
	@Override
	public List<Chatroom> selectChatroomAll() {
		return dao.selectChatroomAll(session);
	}
	
}
