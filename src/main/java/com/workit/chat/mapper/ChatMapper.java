package com.workit.chat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.member.model.dto.Member;


@Mapper
public interface ChatMapper {
	
	List<Chatroom> selectMyChatroomId(String memberId);
	Chat selectAllMyChatroom(String chatroomId);
	
	
	List<MyChatroom> selectMyChatroomById(String memberId);
	List<MyChatroom> selectChatroomByroomId(String chatroomId);
	List<MyChatroom> searchAllByKeyword(String keyword);
	
	List<MyChatroom> selectChatroomIdById(String id);
	List<MyChatroom> checkChatroomMember(String chatroomId);
	
	void insertChatroom(Map<String, Object> param);
	int insertMyChatroom(String memberId);
	
	List<Member> selectMemberAll();
	int insertMyChatroom(Map<String, Object> param);
	int deleteMyChatroom(Map<String, Object> param);
	List<MyChatroom> selectChatByChatroomId(String chatroomId);
	
	List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param);
	
	int insertChat(Chat chat);
	List<MyChatroom> selectChatMember(String chatroomId);
	
	List<MyChatroom> checkChatroomMemberAll(String chatroomId);
}
