package com.workit.meet.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.workit.meet.model.dao.MeetDao;
import com.workit.meet.model.dto.Meet;

@Service
public class MeetServiceImpl implements MeetService {

	private SqlSessionTemplate session;
	
	private MeetDao dao;
	
	public MeetServiceImpl(SqlSessionTemplate session,MeetDao dao) {
		this.session = session;
		this.dao = dao;
	}

	@Override
	public List<Meet> getMeetingsByRoomId(int roomId) {
		return dao.selectMeetByRoomId(session, roomId);
	}

	@Override
	public List<Meet> getMeetingsByRoomIdAndDate(Map<String,Object> paramMap) {
		return dao.getMeetingsByRoomIdAndDate(session, paramMap);
	}

	@Override
	public int insertMeet(Map<String, Object> paramMap) {
		return dao.insertMeet(session, paramMap);
	}

	@Override
	public List<Meet> selectMeetByMember(String memberId) {
		return dao.selectMeetByMember(session, memberId);
	}

	@Override
	public int deleteMeetById(int meetId) {
		return dao.deleteMeetById(session, meetId);
	}

	
}
