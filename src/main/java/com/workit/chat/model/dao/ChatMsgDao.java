package com.workit.chat.model.dao;

import com.workit.chat.model.dto.ChatMsg;

public interface ChatMsgDao {
	int insertChat(ChatMsg chat);
}
