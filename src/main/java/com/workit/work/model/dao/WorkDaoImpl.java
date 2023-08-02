package com.workit.work.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.work.model.dto.Work;

@Repository
public class WorkDaoImpl implements WorkDao {

	@Override
	public int insertStartTime(SqlSessionTemplate session, Work w) {
		return session.insert("work.insertStartTime", w);
	}

	@Override
	public Work selectStartTime(SqlSessionTemplate session, String memberId) {
		return session.selectOne("work.selectStartTime",memberId);
	}

	@Override
	public int updateEndTime(SqlSessionTemplate session, Work w) {
		return session.insert("work.updateEndTime", w);
	}

	@Override
	public Work selectEndTime(SqlSessionTemplate session, String memberId) {
		return session.selectOne("work.selectEndTime",memberId);
	}

	@Override
	public int updateStatus(SqlSessionTemplate session, Work w) {
		return session.update("work.updateStatus", w);
	}

	@Override
	public Work selectWeekTime(SqlSessionTemplate session, String memberId) {
		return session.selectOne("work.selectWeekTime",memberId);
	}

	@Override
	public Work selectMonthTime(SqlSessionTemplate session, String memberId) {
		return session.selectOne("work.selectMonthTime",memberId);
	}

	@Override
	public List<Work> monthWorkTime(SqlSessionTemplate session, Map<String, String> param) {
		return session.selectList("work.monthWorkTime",param);
	}

	@Override
	public List<Work> selectDeptStatus(SqlSessionTemplate session, String memberId) {
		return session.selectList("work.selectDeptStatus",memberId);
	}

	@Override
	public List<Work> selectDeptWork(SqlSessionTemplate session, Map<String, String> param) {
		return session.selectList("work.selectDeptWork",param);
	}

	@Override
	public List<Work> commuteList(SqlSessionTemplate session, Map<String, String> param) {
		return session.selectList("work.commuteList",param);
	}

	@Override
	public List<Work> overworkList(SqlSessionTemplate session, Map<String, String> param) {
		return session.selectList("work.overworkList",param);
	}

	@Override
	public Work monthTotalTime(SqlSessionTemplate session, Map<String, String> param) {
		return session.selectOne("work.monthTotalTime",param);
	}

	@Override
	public List<Work> selectDeptWeekList(SqlSessionTemplate session, Map<String, String> param) {
		return session.selectList("work.selectDeptWeekList",param);
	}

	@Override
	public Work selectMember(SqlSessionTemplate session, String memberId) {
		return session.selectOne("work.selectMember",memberId);
	}

}
