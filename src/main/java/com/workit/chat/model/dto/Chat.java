package com.workit.chat.model.dto;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Chat {
	private String chatId;
	private String chatroomId;
	private String memberId;
	private String chatContent;
	private Date chatDate;
}
