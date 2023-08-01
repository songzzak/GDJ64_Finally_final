package com.workit.chat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;


@Mapper
public interface ChatMapper {
	
	List<MyChatroom> selectMyChatroomById(String memberId);
	List<MyChatroom> selectChatroomByroomId(String chatroomId);
	List<MyChatroom> searchAllByKeyword(String keyword);
	
	void insertChat(Map<String, Object> param);
	int insertMyChatroom(String memberId);
	
	List<Member> selectMemberAll();
	int insertMyChatroom(Map<String, Object> param);
	
}
