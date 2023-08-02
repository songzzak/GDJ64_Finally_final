package com.workit.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ApprovMemberVO {
	private String memberId;
	private String approvalMember;
	private String approvalFl;
	private String updateComment;
	private Date requestDate;
}
