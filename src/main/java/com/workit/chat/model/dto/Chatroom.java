package com.workit.chat.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.workit.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Chatroom {
	private String chatroomId;
	private String chatroomCode;
	private String chatroomTitle;
	private Date chatroomDate;
	private String memberId;
	private List<Chat> chat = new ArrayList<Chat>();
	private List<ChatAttachment> file = new ArrayList<ChatAttachment>();
}
