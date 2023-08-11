package com.workit.board.model.dto;

import java.sql.Date;

import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class Notice {
	int noticeNo;
	String noticeTitle;
	MemberVO member;
	String noticeContent;
	Date noticeDate;
	
}
