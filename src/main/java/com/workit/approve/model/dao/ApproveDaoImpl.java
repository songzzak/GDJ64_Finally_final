package com.workit.approve.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.Time;
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
	public List<Approve> selectAllSaveDocument(SqlSession session, Map<String, Object> param) {
		return session.selectList("approve.selectAllSaveDocument",param);
	}

	@Override
	public List<Approve> detailSave(SqlSession session, Map<String, Object> param) {
		return session.selectList("approve.detailSave",param);
	}

	@Override
	public List<Member> changeDep(SqlSession session, String deptName) {  // 부서클릭할때 각 부서마다 사원들 조회
		return session.selectList("approve.changeDep",deptName);
	}

	@Override
	public Member printMember(SqlSession session, String memberId) { 
		return session.selectOne("approve.printMember",memberId);
	}
	

	@Override
	public int insertApprove(SqlSession session, Approve ap) { // 기안서 테이블 생성
		return session.insert("approve.insertApprove",ap);
	}
	
	@Override
	public int insertTime(SqlSession session, Time t) {  // 시간 테이블 생성
		return session.insert("approve.insertTime",t);
	}

	@Override
	public int insertApproveAttach(SqlSession session, ApproveAttach aa) { // 결재서 첨부파일 테이블 생성
		return session.insert("approve.insertApproveAttach",aa);
	}

	@Override
	public int insertApproveLine(SqlSession session, Map<String, Object> param) { // 결재선 테이블 생성
		return session.insert("approve.insertApproveLine",param);
	}

	@Override
	public int insertReferLine(SqlSession session, Map<String, Object> param) { // 참조선 테이블 생성
		return session.insert("approve.insertReferLine",param);
	}
	
	@Override
	public int insertExpenditure(SqlSession session, Expenditure ex) {
		return session.insert("approve.insertExpenditure",ex);
	}
}
