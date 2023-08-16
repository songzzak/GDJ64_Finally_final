package com.workit.chatroom.service;



import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dto.Chat;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.member.model.dto.Member;

public interface ChatroomService {
	int insertChat(ChatMsg chat);
	//String insertChat(ChatMsg chat);
	//File saveFile(File file, String chatroomId);
	AttachedFile saveFile(MultipartFile file, String chatroomId) throws IOException;
	
	List<ChatroomFile> selectFileByChatroomId(String chatroomId);
	
	List<Member> selectChatMemberById(String chatroomId);
	
	int saveChat(Map<String, Object> param);
	
	int chatNotificationCount(String loginMember);
	
	int deleteNotify(int myChatroomNo);
}
