package com.workit.chatroom.service;



import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.workit.chat.model.dto.ChatMsg;
import com.workit.chatroom.model.dto.AttachedFile;

public interface ChatroomService {
	int insertChat(ChatMsg chat);
	//File saveFile(File file, String chatroomId);
	AttachedFile saveFile(MultipartFile file, String chatroomId) throws IOException;
	
	//List<ChatroomFile> selectFileByChatroomId(String chatroomId);
}
