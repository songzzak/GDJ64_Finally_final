package com.workit.chat.service;

import java.util.List;
import java.util.Map;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.member.model.dto.Member;

public interface ChatService {
	
	Map<String, Object> selectMyChatroomList(String memberId);
	
	Map<String, Object> selectChatroomByroomId(String chatroomId);
	
	List<MyChatroom> searchAllByKeyword(String keyword);
	
	//String insertChatroom(Map<String, Object> param);
	String insertChatroom(String loginMember, Chatroom chatroom);
	
	List<Member> selectMemberAll();
	int deleteMyChatroom(Map<String, Object> param);
	List<MyChatroom> selectChatByChatroomId(String chatroomId);
	List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param);
	
	//int insertChat(Chat chat);
	List<MyChatroom> selectChatMember(String chatroomId);
	
	
	List<MyChatroom> selectCurrentChatMembers(String chatroomId);
	int updateChatroomMember(Map<String, Object> param);
 }