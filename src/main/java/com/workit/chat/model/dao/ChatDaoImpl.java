package com.workit.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.chat.mapper.ChatMapper;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.employee.mapper.EmployeeMapper;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class ChatDaoImpl implements ChatDao {
	
	
	@Autowired
	private ChatMapper mapper;
	
	@Autowired
	private EmployeeMapper Emapper;
	
	@Override
	public List<MyChatroom> selectMyChatroomById(String memberId) {
		return mapper.selectMyChatroomById(memberId);
	}

	@Override
	public List<MyChatroom> selectChatroomByroomId(String chatroomId) {
		return mapper.selectChatroomByroomId(chatroomId);
	}

	@Override
	public List<MyChatroom> searchAllByKeyword(String keyword) {
		return mapper.searchAllByKeyword(keyword);
	}

	@Override
	public void insertChat(Map<String, Object> param) {
		mapper.insertChat(param);
		
	}

	@Override
	public int insertMyChatroom(Map<String, Object> param) {
		log.info("{}", param.get("member"));
		return mapper.insertMyChatroom(param);
	}

	@Override
	public List<Member> selectMemberAll() {
		return Emapper.selectMemberAllByJob();
	}
	
	
	
	
	
	
	
	
}
