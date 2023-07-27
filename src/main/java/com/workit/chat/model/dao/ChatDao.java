package com.workit.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.workit.chat.model.dto.Chatroom;

public interface ChatDao {
	List<Chatroom> selectChatroomAll(SqlSession session);
}
