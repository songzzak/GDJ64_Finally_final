package com.workit.chat.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.workit.chat.model.dao.ChatDao;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;
@Service
public class ChatServiceImpl implements ChatService {
	
	private SqlSession session;
	private ChatDao dao;
	public ChatServiceImpl(SqlSession session, ChatDao dao) {
		this.session = session;
		this.dao = dao;
	}
	
	@Override
	public List<MyChatroom> selectMyChatroomById(String memberId) {
		return dao.selectMyChatroomById(session, memberId);
	}

	@Override
	public List<Chat> selectChatroom(String chatroomId) {
		return dao.selectChatroom(session, chatroomId);
	}

	@Override
	public List<MyChatroom> searchAllByKeyword(String keyword) {
		return dao.searchAllByKeyword(session, keyword);
	}
	
	
	
	
}
