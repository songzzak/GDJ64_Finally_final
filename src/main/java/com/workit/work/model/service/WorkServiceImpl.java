package com.workit.work.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.work.model.dao.WorkDao;
import com.workit.work.model.dto.Work;

@Service
public class WorkServiceImpl implements WorkService {

	private WorkDao dao;
	private SqlSessionTemplate session;
	
	@Autowired
	public WorkServiceImpl(WorkDao dao, SqlSessionTemplate session) {
		this.dao = dao;
		this.session = session;
	}
	
	@Override
	public int insertStartTime(Work w) {
		return dao.insertStartTime(session, w);
	}

	@Override
	public Work selectStartTime(String memberId) {
		return dao.selectStartTime(session, memberId);
	}

	@Override
	public int updateEndTime(Work w) {
		return dao.updateEndTime(session, w);
	}

	@Override
	public Work selectEndTime(String memberId) {
		return dao.selectEndTime(session, memberId);
	}

	@Override
	public int updateStatus(Work w) {
		return dao.updateStatus(session, w);
	}

	@Override
	public Work selectWeekTime(String memberId) {
		return dao.selectWeekTime(session, memberId);
	}

	@Override
	public Work selectMonthTime(String memberId) {
		return dao.selectMonthTime(session, memberId);
	}

	@Override
	public List<Work> monthWorkTime(Map<String, String> param) {
		return dao.monthWorkTime(session, param);
	}

	@Override
	public List<Work> selectDeptStatus(String memberId) {
		return dao.selectDeptStatus(session, memberId);
	}

	@Override
	public List<Work> selectDeptWork(Map<String, String> param) {
		return dao.selectDeptWork(session, param);
	}

	@Override
	public List<Work> commuteList(Map<String, String> param) {
		return dao.commuteList(session, param);
	}

	@Override
	public List<Work> overworkList(Map<String, String> param) {
		return dao.overworkList(session, param);
	}

	@Override
	public Work monthTotalTime(Map<String, String> param) {
		return dao.monthTotalTime(session, param);
	}

	@Override
	public List<Work> selectDeptWeekList(Map<String, String> param) {
		return dao.selectDeptWeekList(session, param);
	}

	@Override
	public Work selectMember(String memberId) {
		return dao.selectMember(session, memberId);
	}

}
