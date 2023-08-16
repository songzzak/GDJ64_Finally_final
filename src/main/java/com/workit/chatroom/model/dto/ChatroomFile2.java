package com.workit.chatroom.model.dto;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.workit.chat.model.dto.Chatroom;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class)
public class ChatroomFile2 {
	private String chatroomFileNo;
	private AttachedFile fileId;
	private Chatroom chatroomId;
}
