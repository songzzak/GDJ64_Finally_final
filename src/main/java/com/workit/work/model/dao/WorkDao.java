package com.workit.work.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.work.model.dto.Work;

public interface WorkDao {
	int insertStartTime(SqlSessionTemplate session, Work w);

	Work selectStartTime(SqlSessionTemplate session, String memberId);

	int updateEndTime(SqlSessionTemplate session, Work w);

	Work selectEndTime(SqlSessionTemplate session, String memberId);

	int updateStatus(SqlSessionTemplate session, Work w);

	Work selectWeekTime(SqlSessionTemplate session, String memberId);

	Work selectMonthTime(SqlSessionTemplate session, String memberId);

	List<Work> monthWorkTime(SqlSessionTemplate session, Map<String, String> param);

	List<Work> selectDeptStatus(SqlSessionTemplate session, String memberId);

	List<Work> selectDeptWork(SqlSessionTemplate session, Map<String, String> param);

	List<Work> commuteList(SqlSessionTemplate session, Map<String, String> param);

	List<Work> overworkList(SqlSessionTemplate session, Map<String, String> param);

	Work monthTotalTime(SqlSessionTemplate session, Map<String, String> param);

	List<Work> selectDeptWeekList(SqlSessionTemplate session, Map<String, String> param);

	Work selectMember(SqlSessionTemplate session, String memberId);

	List<Work> getMonthWorkTime(SqlSessionTemplate session, Map<String, Object> paramMap);
}
