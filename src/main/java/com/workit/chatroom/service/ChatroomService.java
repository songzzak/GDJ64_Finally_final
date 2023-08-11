package com.workit.chatroom.service;



import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dto.ChatMsg;
import com.workit.chatroom.model.dto.AttachedFile;
import com.workit.chatroom.model.dto.ChatroomFile;

public interface ChatroomService {
	int insertChat(ChatMsg chat);
	//File saveFile(File file, String chatroomId);
	AttachedFile saveFile(MultipartFile file, String chatroomId) throws IOException;
	
	List<ChatroomFile> selectFileByChatroomId(String chatroomId);
	
	
}
