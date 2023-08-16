package com.workit.chatroom.dao;

import java.util.List;
import java.util.Map;

import com.workit.chat.model.dto.ChatMsg;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatNotification;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.model.dto.Member;

public interface ChatroomDao {
	int insertChat(ChatMsg chat);
	
	int saveFile(Map<String, Object> param);
	
	int uploadFile(Map<String, Object> param);
	
	AttachedFile selectFileById(String fileId);
	
	List<ChatroomFile> selectFileByChatroomId(String chatroomId);
	
	List<Member> selectChatMemberById(String chatroomId);
	
	int saveChat(ChatNotification chatread);
	
	int chatNotificationCount(String loginMember);
	
	int chatNotificationCountById(Map<String, Object> map);
	
	int deleteNotify(int myChatroomNo);
}
