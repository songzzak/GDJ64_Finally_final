package com.workit.chat.service;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.chat.model.dao.ChatDao;
import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.Chatroom;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.chatroom.dao.ChatroomDao;
import com.workit.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatDao chatDao;
	private ChatroomDao chatroomDao;
	
	public ChatServiceImpl(ChatDao chatDao, ChatroomDao chatroomDao) {
		this.chatDao = chatDao;
		this.chatroomDao = chatroomDao;
	}
	
	@Override
	public Map<String, Object> selectMyChatroomList(String memberId) {
		List<Chatroom> roomNumbers = chatDao.selectMyChatroomId(memberId);
		log.info("{}", roomNumbers);
		Map<String, Object> param = new HashMap<String, Object>();
		List<Chat> list = new ArrayList<Chat>();
		param.put("roomNumbers", roomNumbers);
		if(roomNumbers!=null) {
			for(Chatroom m: roomNumbers) {
				Chat c= chatDao.selectAllMyChatroom(m.getChatroomId());
				list.add(c);
				log.info("{}",list);
			}
			param.put("chat", list);
		}
		param.put("members", chatDao.selectMemberAll());
		param.put("dept", chatDao.selectDeptAll());
		return param;
	}

	@Override
	public Map<String, Object> selectChatroomByroomId(String chatroomId) {
		return Map.of("chatroomList",chatDao.selectChatroomByroomId(chatroomId), "chatroomMember", chatDao.selectChatMember(chatroomId), "chatroomFile", chatroomDao.selectFileByChatroomId(chatroomId));
		//return Map.of("chatroomList",chatDao.selectChatroomByroomId(chatroomId), "chatroomMember", chatDao.selectChatMember(chatroomId));
	}
	
	@Override
	public List<MyChatroom> searchAllByKeyword(String keyword) {
		return chatDao.searchAllByKeyword(keyword);
	}


	@Override
	public String insertChatroom(String loginMember, Chatroom chatroom) {
		String chatroomCode = chatroom.getChatroomCode();
		log.info("{}", chatroomCode);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("chatroomCode", chatroomCode);
		param.put("chatroomTitle", chatroom.getChatroomTitle());
		param.put("loginMember", loginMember);
		log.info("{}", chatroom);
		chatDao.insertChatroom(param);
		
		String[] member = chatroom.getMemberId().split(",");
		param.put("member", member);
		log.info("{}", Arrays.toString((String[])param.get("member")));
		
		
		for(String id:(String[])param.get("member")) {
			chatDao.insertMyChatroom(Map.of("id",id,"chatroomIdSeq",param.get("chatroomIdSeq")));
		}
		return (String)param.get("chatroomIdSeq");
	}

	@Override
	public List<Member> selectMemberAll() {
		return chatDao.selectMemberAll();
	}

	@Override
	public int deleteMyChatroom(Map<String, Object> param) {
		return chatDao.deleteMyChatroom(param);
	}

	@Override
	public List<MyChatroom> selectChatByChatroomId(String chatroomId) {
		return chatDao.selectChatByChatroomId(chatroomId);
	}

	@Override
	public List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param) {
		return chatDao.searchChatroomByKeyword(param);
	}

	@Override
	public List<MyChatroom> selectChatMember(String chatroomId) {
		return chatDao.selectChatMember(chatroomId);
	}

	@Override
	public List<MyChatroom> selectCurrentChatMembers(String chatroomId) {
		return chatDao.selectCurrentChatMembers(chatroomId);
	}

	@Override
	public int updateChatroomMember(Map<String, Object> param) {
		String[] memberArr= ((String)param.get("member")).split(",");
		log.info("{}", param.get("chatroomId"));
		log.info("{}", Arrays.toString(memberArr));
		log.info("{}", memberArr.length);
		String chatroomId = (String)param.get("chatroomId");
		if(memberArr!=null && memberArr.length >1) {
			for(String arr : memberArr) {
				log.info("for문 안");
				log.info("m: "+arr);
				log.info("{}", chatDao.updateChatroomMember(Map.of("memberId", arr,"chatroomId", chatroomId)));
				return chatDao.updateChatroomMember(Map.of("memberId", arr,"chatroomId", chatroomId));
			}
		}
		
		return chatDao.updateChatroomMember(Map.of("memberId",param.get("member"),"chatroomId", chatroomId));
	}
	
	
	
	
	
	
	
	
	
	
	
}
