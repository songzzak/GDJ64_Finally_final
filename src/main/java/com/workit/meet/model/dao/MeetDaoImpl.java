package com.workit.meet.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.meet.model.dto.Meet;

@Repository
public class MeetDaoImpl implements MeetDao {

	@Override
	public List<Meet> selectMeetByRoomId(SqlSessionTemplate session, int roomId) {
		return session.selectList("meet.selectMeetByRoomId",roomId);
	}

	@Override
	public List<Meet> getMeetingsByRoomIdAndDate(SqlSessionTemplate session, Map<String,Object> paramMap) {
		return session.selectList("meet.getMeetingsByRoomIdAndDate",paramMap);
	}

	@Override
	public int insertMeet(SqlSessionTemplate session, Map<String,Object> paramMap) {
		return session.insert("meet.insertMeet",paramMap);
	}



}
