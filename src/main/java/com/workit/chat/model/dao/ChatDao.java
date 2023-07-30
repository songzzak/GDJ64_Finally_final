package com.workit.chat.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;

public interface ChatDao {
	List<MyChatroom> selectMyChatroomById(SqlSession session, String memberId);
	List<Chat> selectChatroom(SqlSession session, String chatroomId);
	List<MyChatroom> searchAllByKeyword(SqlSession session, String keyword);
}
