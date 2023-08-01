package com.workit.approve.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.workit.approve.model.dto.Approve;
import com.workit.member.model.dto.Member;

@Repository
public class ApproveDaoImpl implements ApproveDao {

	@Override
	public List<Approve> selectAllWaitingApprove(SqlSession session, String mId) {
		return session.selectList("approve.selectAllWaitingApprove",mId);
	}

	@Override
	public List<Member> selectAllMember(SqlSession session) {
		return session.selectList("approve.selectAllMember");
	}

	@Override
	public List<Member> changeDep(SqlSession session, String deptName) {
		return session.selectList("approve.changeDep",deptName);
	}
	
	

}
