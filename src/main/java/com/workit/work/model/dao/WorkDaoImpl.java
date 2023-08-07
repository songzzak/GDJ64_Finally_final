package com.workit.work.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.work.model.dto.Work;

@Repository
public class WorkDaoImpl implements WorkDao {

	@Override
	public List<Work> getMonthWorkTime(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.selectList("work.getMonthWorkTime", paramMap);
	}

	@Override
	public int insertStartWorkTime(SqlSessionTemplate session, Work w) {
		return session.insert("work.insertStartWorkTime",w);
	}

	@Override
	public boolean isWorkDataRegisteredForDate(SqlSessionTemplate session, Map<String, String> mapParam) {
		int count = session.selectOne("work.isWorkDataRegisteredForDate",mapParam);
		return count>0;
	}

	@Override
	public Work selectWorkByDateAndMemberId(SqlSessionTemplate session, Map<String, Object> paramMap) {
		return session.selectOne("work.selectWorkByDateAndMemberId",paramMap);
	}

}
