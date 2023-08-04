package com.workit.approve.model.dto;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Approve {
	private int approveNo;
	private String approveTitle;
	private String approveContent;
	private Date currentDate;
	private String memberId;
	private String approveState;
	private String approveKind;
}
