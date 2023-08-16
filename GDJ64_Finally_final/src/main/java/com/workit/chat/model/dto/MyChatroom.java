package com.workit.chat.model.dto;


import com.workit.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MyChatroom {
	private int myChatroomNo;
	private Chatroom chatroom;
	private Member member;
}
