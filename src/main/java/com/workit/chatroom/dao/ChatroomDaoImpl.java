package com.workit.chatroom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.workit.chat.mapper.ChatMapper;
import com.workit.chat.model.dto.ChatMsg;
import com.workit.chatroom.mapper.ChatroomFileMapper;
import com.workit.chatroom.model.dto.ChatroomFile;
import com.workit.chatroom.model.dto.AttachedFile;

import lombok.extern.slf4j.Slf4j;
@Repository
@Slf4j
public class ChatroomDaoImpl implements ChatroomDao {
	
	private ChatroomFileMapper chatfileMapper;
	private ChatMapper chatMapper;
	
	public ChatroomDaoImpl(ChatMapper chatMapper, ChatroomFileMapper chatfileMapper) {
		this.chatMapper = chatMapper;
		this.chatfileMapper = chatfileMapper;
	}
	
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

//	@Override
//	public int saveFile(Map<String, Object> file) {
//		return chatfileMapper.saveFile(file);
//	}
//
//	@Override
//	public int uploadFile(Map<String, Object> param) {
//		return chatfileMapper.uploadFile(param);
//	}
//
//	@Override
//	public File selectFileById(String fileId) {
//		return chatfileMapper.selectFileById(fileId);
//	}
	
	
	
	
}
