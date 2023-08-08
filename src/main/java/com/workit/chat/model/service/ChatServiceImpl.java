package com.workit.chat.model.service;


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
import com.workit.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatDao chatDao;
	
	public ChatServiceImpl(ChatDao chatDao) {
		this.chatDao = chatDao;
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
		return Map.of("chatroomList",chatDao.selectChatroomByroomId(chatroomId), "chatroomMember", chatDao.checkChatroomMember(chatroomId));
	}
	
	@Override
	public List<MyChatroom> searchAllByKeyword(String keyword) {
		return chatDao.searchAllByKeyword(keyword);
	}


	@Override
	public String insertChatroom(String loginMember, Chatroom chatroom) {
	//public String insertChatroom(Map<String, Object> param) {
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
//	public String insertChatroom(String loginMember, Chatroom chatroom) {
//		//public String insertChatroom(Map<String, Object> param) {
//			//Chatroom chatroom =(Chatroom)param.get("chatroom");
//			log.info("{}", chatroom.getChatroomCode());
//			String chatroomCode = chatroom.getChatroomCode();
//			
//			
//			param.put("chatroomCode", chatroomCode);
//			log.info("{}", chatroom);
////			String[] member = chatroom.getMemberId().split(",");
////			param.put("member", member);
////			log.info("{}", Arrays.toString((String[])param.get("member")));
//			
//			chatDao.insertChatroom(param);
//			
//			for(String id:(String[])param.get("member")) {
//				chatDao.insertMyChatroom(Map.of("id",id,"chatroomIdSeq",param.get("chatroomIdSeq")));
//			}
//			return (String)param.get("chatroomIdSeq");
//		}

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
	public List<MyChatroom> checkChatroomMember(String chatroomId) {
		return chatDao.checkChatroomMemberAll(chatroomId);
	}

	@Override
	public int updateChatroomMember(Map<String, Object> param) {
		log.info("{}", param.get("member"));
		String[] memberArr= ((String)param.get("member")).split(",");
		log.info("{}", param.get("chatroomId"));
		log.info("{}", Arrays.toString(memberArr));
		log.info("{}", memberArr.length);
		String chatroomId = (String)param.get("chatroomId");
		if(memberArr.length >1) {
			for(String m : memberArr) {
				log.info("for문 안");
				log.info("m: "+m);
				log.info("{}", chatDao.updateChatroomMember(Map.of("memberId", m,"chatroomId", chatroomId)));
				return chatDao.updateChatroomMember(Map.of("memberId", m,"chatroomId", chatroomId));
			}
		}
		return chatDao.updateChatroomMember(Map.of("memberId",param.get("member"),"chatroomId", chatroomId));
	}
	
	
	
	
	
	
	
	
	
	
	
}
