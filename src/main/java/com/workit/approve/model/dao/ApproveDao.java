package com.workit.approve.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.Time;
import com.workit.member.model.dto.Member;

public interface ApproveDao {
	public List<Approve> selectAllWaitingApprove(SqlSession session,String mId);
	public List<Member> selectAllMember(SqlSession session);
	public List<Member> changeDep(SqlSession session,String deptName);
	public Member printMember(SqlSession session,String memberId);
	public int insertApprove(SqlSession session, Approve ap);
	public int insertTime(SqlSession session, Time t);
	public int insertApproveAttach(SqlSession session, ApproveAttach aa);
	public int insertApproveLine(SqlSession session, Map<String,Object> param);
	public int insertReferLine(SqlSession session, Map<String,Object> param);
	public int insertExpenditure(SqlSession session, Expenditure ex);
}
