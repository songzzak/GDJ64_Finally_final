package com.workit.work.model.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Work {
	private int workNo;
	private Date workDate;
	private Timestamp workStart;
	private Timestamp workEnd;
	private String workStatus;
	private String memberId;
}
