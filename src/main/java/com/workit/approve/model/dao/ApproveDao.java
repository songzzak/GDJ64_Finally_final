package com.workit.approve.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.workit.approve.model.dto.Approve;
import com.workit.member.model.dto.Member;

public interface ApproveDao {
	public List<Approve> selectAllWaitingApprove(SqlSession session,String mId);
	public List<Member> selectAllMember(SqlSession session);
	public List<Member> changeDep(SqlSession session,String deptName);
	public Member printMember(SqlSession session,String memberId);
}
