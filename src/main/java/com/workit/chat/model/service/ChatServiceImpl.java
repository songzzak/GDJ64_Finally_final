package com.workit.chat.model.service;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.chat.model.dao.ChatDao;
import com.workit.chat.model.dto.MyChatroom;
import com.workit.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatDao dao;
	
	@Override
	public List<MyChatroom> selectMyChatroomById(String memberId) {
		return dao.selectMyChatroomById(memberId);
	}

	@Override
	public List<MyChatroom> selectChatroomByroomId(String chatroomId) {
		return dao.selectChatroomByroomId(chatroomId);
	}

	@Override
	public List<MyChatroom> searchAllByKeyword(String keyword) {
		return dao.searchAllByKeyword(keyword);
	}


	@Override
	public List<MyChatroom> insertChat(Map<String, Object> param) {
		dao.insertChat(param);
		for(String id:(String[])param.get("member")) {
			dao.insertMyChatroom(Map.of("id",id,"chatroomIdSeq",param.get("chatroomIdSeq")));
		}
		String chatroomId = (String)param.get("chatroomIdSeq");
		log.info("{}", chatroomId);
		
		if(chatroomId!=null || chatroomId !="") {
			log.info("{}", dao.selectChatroomByroomId(chatroomId));
		}
		return dao.selectChatroomByroomId(chatroomId);
	}

	@Override
	public List<Member> selectMemberAll() {
		return dao.selectMemberAll();
	}
	
	
	
	
	
	
	
}
