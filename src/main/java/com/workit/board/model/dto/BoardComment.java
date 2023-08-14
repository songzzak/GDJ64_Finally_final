package com.workit.board.model.dto;

import java.sql.Date;

import com.workit.member.model.vo.MemberVO;

public class BoardComment {
	int commentNo;
	MemberVO member;
	String commentContent;
	Date commentDate;
	int refCommentNo;
	Notice notice;
}
