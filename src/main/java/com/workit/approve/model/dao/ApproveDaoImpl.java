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
	public List<Approve> selectAllWaitingApprove(SqlSession session, Map<String,Object> param) {
		return session.selectList("approve.selectAllWaitingApprove",param);
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
	public List<Expenditure> detailExpenditures(SqlSession session, Map<String, Object> param) {
		return session.selectList("approve.detailExpenditures",param);
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
	
	@Override
	public int reInsertApporve(SqlSession session, Approve ap) {  // 임시저장된 화면에서 다시 임시저장할때 다시 기안서 테이블 만들어지는작업
		return session.insert("approve.reInsertApporve",ap);
	}

	@Override
	public int reInsertTime(SqlSession session, Time t) { // 임시저장된 화면에서 다시 임시저장할때 다시 시간테이블 만들어지는작업
		return session.insert("approve.reInsertTime",t);
	}

	@Override
	public int reInsertApproveAttach(SqlSession session, ApproveAttach aa) { // 임시저장된 화면에서 다시 임시저장할때 다시 첨부파일 테이블 만들어지는작업
		return session.insert("approve.reInsertApproveAttach",aa);
	}

	@Override
	public int reInsertApproveLine(SqlSession session, Map<String, Object> param) {// 임시저장된 화면에서 다시 임시저장할때 다시 결재서테이블 만들어지는작업
		return session.insert("approve.reInsertApproveLine",param);
	}

	@Override
	public int reInsertReferLine(SqlSession session, Map<String, Object> param) { // 임시저장된 화면에서 다시 임시저장할때 다시 참조선 테이블 만들어지는작업
		return session.insert("approve.reInsertReferLine",param);
	}

	@Override
	public int reInsertExpenditure(SqlSession session, Expenditure ex) { // 임시저장된 화면에서 다시 임시저장할때 다시 지출결의서 테이블 만들어지는작업
		return session.insert("approve.reInsertExpenditure",ex);
	}

	@Override
	public int approveAssign(SqlSession session, Map<String, Object> param) { // 결재선의 상태를 완료로 바꾸는 작업
		return session.update("approve.approveAssign",param);
	}

	@Override
	public int selectTotalLineCnt(SqlSession session, Map<String, Object> param) { // 해당 기안서의 결재선의 총 개수 구하기
		return session.selectOne("approve.selectTotalLineCnt",param);
	}

	@Override
	public int selectCompleteLineCnt(SqlSession session, Map<String, Object> param) { // 해당 기안서의 결재선중 완료처리된 개수 구하기
		return session.selectOne("approve.selectCompleteLineCnt",param);
	}

	@Override
	public int plusCurrentOrder(SqlSession session, Map<String, Object> param) {
		return session.selectOne("approve.plusCurrentOrder",param);
	}
	
	
}
