package com.workit.approve.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.approve.model.dao.ApproveDao;
import com.workit.approve.model.dto.Approve;
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
	public List<Member> changeDep(String deptName) {
		return dao.changeDep(session,deptName);
	}

	@Override
	public Member printMember(String memberId) {
		return dao.printMember(session,memberId);
	}
	
	

}
