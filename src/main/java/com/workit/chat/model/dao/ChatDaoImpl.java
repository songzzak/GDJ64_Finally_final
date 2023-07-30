package com.workit.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.chat.mapper.ChatMapper;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
@Repository
public class ChatDaoImpl implements ChatDao {
	
	@Override
	public List<MyChatroom> selectMyChatroomById(SqlSession session, String memberId) {
		return session.selectList("chat.selectMyChatroomById",memberId);
	}

	@Override
	public List<Chat> selectChatroom(SqlSession session, String chatroomId) {
		return session.selectList("chat.selectChatroom",chatroomId);
	}

	@Override
	public List<MyChatroom> searchAllByKeyword(SqlSession session, String keyword) {
		return session.selectList("chat.searchAllByKeyword", keyword);
	}
	
	
	
}
