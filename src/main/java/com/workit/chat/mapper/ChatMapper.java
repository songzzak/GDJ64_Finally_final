package com.workit.chat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.workit.chat.model.dto.MyChatroom;


@Mapper
public interface ChatMapper {
//	@Select("SELECT * FROM MEMBER")
//	List<MemberDto> selectMemberAll();
//	
//	@Select(value = "SELECT * FROM MEMBER WHERE USERID=#{id}")
//	MemberDto selectMemberById(String id);
//	
//	@SelectProvider(type=MemberSelectBuilder.class, method="selectMemberByWhere")
//	List<MemberDto> selectMemberByWhere(Map<String,Object> param);
	
	@Select(value = "SELECT * FROM MY_CHATROOM_TB WHERE MEMBER_ID=#{memberId}")
	List<MyChatroom> selectMyChatroomById(String memberId);
	
}
