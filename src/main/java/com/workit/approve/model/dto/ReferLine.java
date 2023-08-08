package com.workit.approve.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReferLine {
	private int referLineNo;
	private int approveNo;
	private String memberId;
}
