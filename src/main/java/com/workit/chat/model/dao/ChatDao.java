package com.workit.chat.model.dao;

import java.util.List;
import java.util.Map;


import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;

public interface ChatDao {
	List<MyChatroom> selectMyChatroomById(String memberId);
	List<MyChatroom> selectChatroomByroomId(String chatroomId);
	List<MyChatroom> searchAllByKeyword(String keyword);
	
	void insertChat(Map<String, Object> param);
	int insertMyChatroom(Map<String, Object> param);
	List<Member> selectMemberAll();
}
