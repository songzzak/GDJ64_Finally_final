package com.workit.approve.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.ApproveLine;
import com.workit.approve.model.dto.Expenditure;
import com.workit.approve.model.dto.ReferLine;
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
	public List<Approve> selectAllSaveDocument(SqlSession session, Map<String, Object> param) { // 본인이 작성한 임시저장 문서들 다 조회
		return session.selectList("approve.selectAllSaveDocument",param);
	}

	@Override
	public List<Approve> detailSave(SqlSession session, Map<String, Object> param) { // 임시작성된 기안서 상세 객체 보기
		return session.selectList("approve.detailSave",param);
	}
	
	@Override
	public List<ApproveLine> detailApproveLines(SqlSession session, Map<String, Object> param) { // 임시작성된 기안서 번호와 참조되는 결재선 상세 객체보기
		return session.selectList("approve.detailApproveLines",param);
	}

	@Override
	public List<ReferLine> detailReferLines(SqlSession session, Map<String, Object> param) { // 임시작성된 기안서 번호와 참조되는 참조선 상세 객체보기
		return session.selectList("approve.detailReferLines",param);
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
	public int insertExpenditure(SqlSession session, Expenditure ex) { // 지출결의서 테이블 생성
		return session.insert("approve.insertExpenditure",ex);
	}
	
	@Override
	public int removeSave(SqlSession session, String deleteApproveNo) { // 기안서번호를 통해 기안서 삭제(참조되는것 다 삭제)
		return session.delete("approve.removeSave",deleteApproveNo);
	}
}
