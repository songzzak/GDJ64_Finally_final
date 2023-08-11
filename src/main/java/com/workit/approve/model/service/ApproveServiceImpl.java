package com.workit.approve.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.approve.model.dao.ApproveDao;
import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.ApproveLine;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.ReferLine;
import com.workit.approve.model.dto.Time;
import com.workit.member.model.dto.Member;

@Service
public class ApproveServiceImpl implements ApproveService {

	@Autowired
	private ApproveDao dao;
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Approve> selectAllWaitingApprove(String mId) {
		return dao.selectAllWaitingApprove(session,mId);
	}

	@Override
	public List<Member> selectAllMember() {
		return dao.selectAllMember(session);
	}


	@Override
	public List<Approve> selectAllSaveDocument(Map<String, Object> param) {
		return dao.selectAllSaveDocument(session,param);
	}

	@Override
	public List<Approve> detailSave(Map<String, Object> param) {
		return dao.detailSave(session,param);
	}
	
	@Override
	public List<ApproveLine> detailApproveLines(Map<String, Object> param) {
		return dao.detailApproveLines(session,param);
	}

	@Override
	public List<ReferLine> detailReferLines(Map<String, Object> param) {
		return dao.detailReferLines(session,param);
	}
	
	
	@Override
	public int removeSave(String deleteApproveNo) {
		return dao.removeSave(session,deleteApproveNo);
	}

	@Override
	public List<Member> changeDep(String deptName) {
		return dao.changeDep(session,deptName);
	}

	@Override
	public Member printMember(String memberId) {
		return dao.printMember(session,memberId);
	}

	@Override
	public int insertApprove(Approve ap) {
		return dao.insertApprove(session,ap);
	}
	
	@Override
	public int insertTime(Time t) {
		return dao.insertTime(session,t);
	}

	@Override
	public int insertApproveAttach(ApproveAttach aa) {
		return dao.insertApproveAttach(session,aa);
	}
	
	@Override
	public int insertApproveLine(Map<String, Object> param) {
		return dao.insertApproveLine(session,param);
	}

	@Override
	public int insertReferLine(Map<String, Object> param) {
		return dao.insertReferLine(session,param);
	}
	
	@Override
	public int insertExpenditure(Expenditure ex) {
		return dao.insertExpenditure(session, ex);
	}

	@Override
	public int reInsertApprove(Approve ap) {
		return dao.reInsertApporve(session,ap);
	}

	@Override
	public int reInsertTime(Time t) {
		return dao.reInsertTime(session, t);
	}

	@Override
	public int reInsertApproveAttach(ApproveAttach aa) {
		return dao.reInsertApproveAttach(session, aa);
	}

	@Override
	public int reInsertApproveLine(Map<String, Object> param) {
		return dao.reInsertApproveLine(session, param);
	}

	@Override
	public int reInsertReferLine(Map<String, Object> param) {
		return dao.reInsertReferLine(session, param);
	}
	
	
}
