package com.workit.approve.service;

import java.util.List;

import com.workit.approve.model.dto.Approve;

public interface ApproveService {
	/* public List<Approve> selectAllWaitingApprove(String memberId); */
	public List<Approve> selectAllWaitingApprove(String memberId);
}
