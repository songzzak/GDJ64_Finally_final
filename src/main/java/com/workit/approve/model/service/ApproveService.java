package com.workit.approve.model.service;

import java.util.List;
import java.util.Map;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.Time;
import com.workit.member.model.dto.Member;

public interface ApproveService {
	/* public List<Approve> selectAllWaitingApprove(String memberId); */
	public List<Approve> selectAllWaitingApprove(String memberId);
	public List<Member> selectAllMember();
	public List<Member> changeDep(String deptName);
	public Member printMember(String memberId);
	public int insertApprove(Approve ap);
	public int insertTime(Time t);
	public int insertApproveAttach(ApproveAttach aa);
	public int insertApproveLine(Map<String,Object> param);
	public int insertReferLine(Map<String,Object> param);
	public int insertExpenditure(Expenditure ex);
	public List<Approve> selectAllSaveDocument(Map<String,Object> param);
	public List<Approve> detailSave(Map<String,Object> param);
	
}
