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
	public List<Chatroom> selectMyChatroomId(String memberId) {
		return mapper.selectMyChatroomId(memberId);
	}

	@Override
	public Chat selectAllMyChatroom(String chatroomId) {
		return mapper.selectAllMyChatroom(chatroomId);
	}

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
	public void insertChatroom(Map<String, Object> param) {
		mapper.insertChatroom(param);
		
	}

	@Override
	public int insertMyChatroom(Map<String, Object> param) {
		return mapper.insertMyChatroom(param);
	}

	@Override
	public List<Member> selectMemberAll() {
		return Emapper.selectMemberAllByJob();
	}

	@Override
	public int deleteMyChatroom(Map<String, Object> param) {
		return mapper.deleteMyChatroom(param);
	}

	@Override
	public List<MyChatroom> selectChatByChatroomId(String chatroomId) {
		log.info("{}", mapper.selectChatByChatroomId(chatroomId));
		return mapper.selectChatByChatroomId(chatroomId);
	}

	@Override
	public List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param) {
		return mapper.searchChatroomByKeyword(param);
	}

	@Override
	public List<MyChatroom> selectChatroomIdById(String id) {
		return mapper.selectChatroomIdById(id);
	}

	@Override
	public List<MyChatroom> checkChatroomMember(String chatroomId) {
		log.info("{}",mapper.checkChatroomMember(chatroomId));
		return mapper.checkChatroomMember(chatroomId);
	}

	@Override
	public int insertChat(Chat chat) {
		return mapper.insertChat(chat);
	}

	@Override
	public List<MyChatroom> selectChatMember(String chatroomId) {
		log.info("{}", mapper.selectChatMember(chatroomId));
		return mapper.selectChatMember(chatroomId);
	}

	@Override
	public List<MyChatroom> checkChatroomMemberAll(String chatroomId) {
		return mapper.checkChatroomMemberAll(chatroomId);
	}
	
	
	
	
	
	
}
