package com.workit.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.chat.mapper.ChatMapper;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.employee.mapper.EmployeeMapper;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class ChatDaoImpl implements ChatDao {
	
	
	@Autowired
	private ChatMapper chatMapper;
	
	@Autowired
	private EmployeeMapper EmpMapper;
	
	public ChatDaoImpl(ChatMapper chatMapper, EmployeeMapper EmpMapper) {
		this.chatMapper = chatMapper;
		this.EmpMapper = EmpMapper;
	}
	
	@Override
	public List<Chatroom> selectMyChatroomId(String memberId) {
		return chatMapper.selectMyChatroomId(memberId);
	}

	@Override
	public Chat selectAllMyChatroom(String chatroomId) {
		return chatMapper.selectAllMyChatroom(chatroomId);
	}

	@Override
	public List<Chatroom> selectChatroomByroomId(String chatroomId) {
		return chatMapper.selectChatroomByroomId(chatroomId);
	}
	
	@Override
	public List<MyChatroom> searchAllByKeyword(String keyword) {
		return chatMapper.searchAllByKeyword(keyword);
	}

	@Override
	public void insertChatroom(Map<String, Object> param) {
		chatMapper.insertChatroom(param);
	}

	@Override
	public int insertMyChatroom(Map<String, Object> param) {
		return chatMapper.insertMyChatroom(param);
	}

	@Override
	public List<Member> selectMemberAll() {
		return EmpMapper.selectMemberAllByJob();
	}
	
	@Override
	public List<Department> selectDeptAll() {
		return EmpMapper.selectDeptAll();
	}

	@Override
	public int deleteMyChatroom(Map<String, Object> param) {
		return chatMapper.deleteMyChatroom(param);
	}

	@Override
	public List<MyChatroom> selectChatByChatroomId(String chatroomId) {
		log.info("{}", chatMapper.selectChatByChatroomId(chatroomId));
		return chatMapper.selectChatByChatroomId(chatroomId);
	}

	@Override
	public List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param) {
		return chatMapper.searchChatroomByKeyword(param);
	}

	@Override
	public List<MyChatroom> selectChatroomIdById(String id) {
		return chatMapper.selectChatroomIdById(id);
	}

	@Override
	public List<MyChatroom> checkChatroomMember(String chatroomId) {
		log.info("{}",chatMapper.checkChatroomMember(chatroomId));
		return chatMapper.checkChatroomMember(chatroomId);
	}

	@Override
	public List<MyChatroom> selectChatMember(String chatroomId) {
		log.info("{}", chatMapper.selectChatMember(chatroomId));
		return chatMapper.selectChatMember(chatroomId);
	}

	@Override
	public List<MyChatroom> checkChatroomMemberAll(String chatroomId) {
		return chatMapper.checkChatroomMemberAll(chatroomId);
	}

	@Override
	public int updateChatroomMember(Map<String, Object> param) {
		return chatMapper.updateChatroomMember(param);
	}
	
	
	
	
	
	
	
}
