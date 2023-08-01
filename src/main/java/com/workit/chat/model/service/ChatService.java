package com.workit.chat.model.service;

import java.util.List;
import java.util.Map;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;

public interface ChatService {
	List<MyChatroom> selectMyChatroomById(String memberId);
	List<MyChatroom> selectChatroomByroomId(String chatroomId);
	List<MyChatroom> searchAllByKeyword(String keyword);
	List<MyChatroom> insertChat(Map<String, Object> param);
	//List<Department> selectAllDept();
	List<Member> selectMemberAll();
 }
