package com.workit.work.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.work.model.dto.Work;
import com.workit.work.model.dto.WorkChange;

public interface WorkDao {
	
	List<Work> getMonthWorkTime(SqlSessionTemplate session, Map<String, Object> paramMap);

	int insertStartWorkTime(SqlSessionTemplate session, Work w);

	boolean isWorkDataRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam);

	Work selectWorkByDateAndMemberId(SqlSessionTemplate session, Map<String, Object> paramMap);

	boolean isCheckOutRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam);

	int updateEndWorkTime(SqlSessionTemplate session, Work w);

	int lateCount(SqlSessionTemplate session, Map<String, Object> paramMap);

	int earlyLeaveCount(SqlSessionTemplate session, Map<String, Object> paramMap);

	int insertWorkchange(SqlSessionTemplate session, WorkChange wc);
}
