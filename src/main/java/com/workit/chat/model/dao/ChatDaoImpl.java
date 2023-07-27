package com.workit.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.workit.chat.model.dto.Chatroom;
@Repository
public class ChatDaoImpl implements ChatDao {

	@Override
	public List<Chatroom> selectChatroomAll(SqlSession session) {
		return session.selectList("chat.selectChatroomAll");
	}

}
