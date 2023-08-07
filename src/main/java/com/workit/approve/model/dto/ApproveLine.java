package com.workit.approve.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ApproveLine {
	private int approveLineNo;
	private int approveOrder;
	private int approveNo;
	private String approveStatus;
	private Date approveDate;
	private String memberId;
}
