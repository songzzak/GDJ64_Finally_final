package com.workit.board.model.dto;

import java.sql.Date;

import com.workit.member.model.vo.MemberVO;

public class Board {
	int boardNo;
	String boardTitle;
	MemberVO member;
	String boardContent;
	Date boardDate;
	int viewCount;
	int commentCount;
}
