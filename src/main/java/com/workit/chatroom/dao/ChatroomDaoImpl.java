package com.workit.chatroom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.chat.mapper.ChatMapper;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatNotification;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.mapper.MemberMapper;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.MemberVO;
@Repository
public class ChatroomDaoImpl implements ChatroomDao {
	
	@Autowired
	private ChatMapper chatMapper;
	@Autowired
	private MemberMapper memberMapper;
	
	
	@Override
	public int insertChat(ChatMsg chat) {
		return chatMapper.insertChat(chat);
	}

	@Override
	public int saveFile(Map<String, Object> file) {
		return chatMapper.saveFile(file);
	}

	@Override
	public int uploadFile(Map<String, Object> param) {
		return chatMapper.uploadFile(param);
	}

	@Override
	public AttachedFile selectFileById(String fileId) {
		return chatMapper.selectFileById(fileId);
	}

	@Override
	public List<ChatroomFile> selectFileByChatroomId(String chatroomId) {
		return chatMapper.selectFileByChatroomId(chatroomId);
	}

	@Override
	public List<Member> selectChatMemberById(String chatroomId) {
		return chatMapper.selectChatMemberById(chatroomId);
	}

	@Override
	public int saveChat(ChatNotification chatread) {
		return chatMapper.saveChat(chatread);
	}

	@Override
	public int chatNotificationCount(String loginMember) {
		return chatMapper.chatNotificationCount(loginMember);
	}

	@Override
	public int chatNotificationCountById(Map<String, Object> param) {
		return chatMapper.chatNotificationCountById(param);
	}

	@Override
	public int deleteNotify(int myChatroomNo) {
		return chatMapper.deleteNotify(myChatroomNo);
	}

	@Override
	public MemberVO selectMemberByChoice(String memberId) {
		return memberMapper.selectMemberByParam(Map.of("memberId", memberId));
	}
	
	
	
	
	
	
	
}
