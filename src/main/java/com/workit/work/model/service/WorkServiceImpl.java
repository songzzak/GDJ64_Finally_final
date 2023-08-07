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
	public List<Work> getMonthWorkTime(Map<String, Object> paramMap) {
		return dao.getMonthWorkTime(session, paramMap);
	}

	@Override
	public int insertStartWorkTime(Work w) {
		return dao.insertStartWorkTime(session,w);
	}

	@Override
	public boolean isWorkDataRegisteredForDate(Map<String, String> mapParam) {
		return dao.isWorkDataRegisteredForDate(session,mapParam);
	}

	@Override
	public Work selectWorkByDateAndMemberId(Map<String, Object> paramMap) {
		return dao.selectWorkByDateAndMemberId(session,paramMap);
	}

	@Override
	public boolean isCheckOutRegisteredForDate(Map<String, String> mapParam) {
		return dao.isCheckOutRegisteredForDate(session,mapParam);
	}

	@Override
	public int updateEndWorkTime(Work w) {
		return dao.updateEndWorkTime(session, w);
	}

	@Override
	public int lateCount(Map<String, Object> paramMap) {
		return dao.lateCount(session,paramMap);
	}

	@Override
	public int earlyLeaveCount(Map<String, Object> paramMap) {
		return dao.earlyLeaveCount(session,paramMap);
	}



}
