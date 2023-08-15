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

	@Override
	public List<Meet> selectMeetByMember(SqlSessionTemplate session, String memberId) {
		return session.selectList("meet.selectMeetByMember",memberId);
	}

	@Override
	public int deleteMeetById(SqlSessionTemplate session, int meetId) {
		return session.delete("meet.deleteMeetById",meetId);
	}



}
