package com.workit.work.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.work.model.dto.Work;

public interface WorkDao {
	
	List<Work> getMonthWorkTime(SqlSessionTemplate session, Map<String, Object> paramMap);

	int insertStartWorkTime(SqlSessionTemplate session, Work w);

	boolean isWorkDataRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam);

	Work selectWorkByDateAndMemberId(SqlSessionTemplate session, Map<String, Object> paramMap);
}
