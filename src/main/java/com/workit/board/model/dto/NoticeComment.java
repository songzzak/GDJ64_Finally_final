package com.workit.board.model.dto;

import java.sql.Date;

import com.workit.member.model.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NoticeComment {
	int commentNo;
	MemberVO member;
	String commentContent;
	Date commentDate;
	int refCommentNo;
	Notice notice;
}
