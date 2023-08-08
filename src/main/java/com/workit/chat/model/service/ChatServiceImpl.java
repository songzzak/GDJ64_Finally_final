package com.workit.chat.model.service;


import java.util.ArrayList;
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
	private ChatDao dao;
	
	
	
	@Override
	public Map<String, Object> selectMyChatroomList(String memberId) {
		List<Chatroom> roomNumbers = dao.selectMyChatroomId(memberId);
		log.info("{}", roomNumbers);
		Map<String, Object> param = new HashMap<String, Object>();
		List<Chat> list = new ArrayList<Chat>();
		param.put("roomNumbers", roomNumbers);
		if(roomNumbers!=null) {
			for(Chatroom m: roomNumbers) {
				Chat c= dao.selectAllMyChatroom(m.getChatroomId());
				list.add(c);
				log.info("{}",list);
			}
			param.put("chat", list);
		}
		return param;
	}

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
	public String insertChatroom(Map<String, Object> param) {
//		String loginMember = (String)param.get("loginMember");
//		log.info("{}", loginMember);
//		
//		// 1:1 채팅 생성 
//		if(param.get("chatroomCode").equals("P")) {
//			// chatroom code가 p고 param.get("member")가 my_chatroom_tb에서 member_id가 있을 때 chatroom_id가 
//		}
//		
//		
//		
//		List<MyChatroom> myChatAll = dao.selectChatroomIdById(loginMember);
//		log.info("{}",myChatAll);
//		//dao.checkChatroomMember(check);
//		//Map<String, Object> check = new HashMap<String, Object>();
//		if(myChatAll!=null) {
//			for(MyChatroom m : myChatAll) {
//					//roomList[i] = m.getChatroomId();
//					log.info("{}",m.getChatroomId());
//					List<MyChatroom> selectMyChat = dao.checkChatroomMember(m.getChatroomId());
////					log.info("{}", selectMyChat);
////					for(MyChatroom mc : selectMyChat) {
////						List<Member> mem = mc.getMember();
////						for(Member mb : mem) {
////							mb.getMemberId().equals(myChatAll)
////						}
////					}
//			}
//		}else {
//			dao.insertChat(param);
//			for(String id:(String[])param.get("member")) {
//				dao.insertMyChatroom(Map.of("id",id,"chatroomIdSeq",param.get("chatroomIdSeq")));
//			}
//		}
		
		dao.insertChatroom(param);
		for(String id:(String[])param.get("member")) {
			dao.insertMyChatroom(Map.of("id",id,"chatroomIdSeq",param.get("chatroomIdSeq")));
		}
		return (String)param.get("chatroomIdSeq");
	}

	@Override
	public List<Member> selectMemberAll() {
		return dao.selectMemberAll();
	}

	@Override
	public int deleteMyChatroom(Map<String, Object> param) {
		return dao.deleteMyChatroom(param);
	}

	@Override
	public List<MyChatroom> selectChatByChatroomId(String chatroomId) {
		return dao.selectChatByChatroomId(chatroomId);
	}

	@Override
	public List<MyChatroom> searchChatroomByKeyword(Map<String, Object> param) {
		return dao.searchChatroomByKeyword(param);
	}

	@Override
	public int insertChat(Chat chat) {
		return dao.insertChat(chat);
	}

	@Override
	public List<MyChatroom> selectChatMember(String chatroomId) {
		return dao.selectChatMember(chatroomId);
	}
	
	
	
	
	
	
	
	
	
	
	
}
