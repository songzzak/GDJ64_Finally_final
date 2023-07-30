package com.workit.chat.model.dto;

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
	private String chatroomId;
	private String memberId;
}
