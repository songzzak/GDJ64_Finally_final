package com.workit.board.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.board.model.dao.BoardDao;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;

@Service
public class BoardServiceImpl implements BoardService {
	private BoardDao dao;
	private SqlSessionTemplate session;
	
	@Autowired
	public BoardServiceImpl(BoardDao dao, SqlSessionTemplate session) {
		this.dao = dao;
		this.session = session;
	}

	@Override
	public List<Notice> selectNoticeAll(Map<String, Integer> map) {
		return dao.selectNoticeAll(session,map);
	}

	@Override
	public int selectNoticeCount() {
		return dao.selectNoticeCount(session);
	}

	@Override
	public Notice selectNoticeByNo(int no) {
		return dao.selectNoticeByNo(session,no);
	}

	@Override
	public int insertNoticeComment(Map<String, Object> map) {
		return dao.insertNoticeComment(session, map);
	}

	@Override
	public List<NoticeComment> selectCommentList(int no) {
		return dao.selectCommentList(session, no);
	}

	@Override
	public int deleteNoticeComment(int commentNo) {
		return dao.deleteNoticeComment(session,commentNo);
	}

	@Override
	public int updateNoticeComment(Map<String, Object> map) {
		return dao.updateNoticeComment(session,map);
	}


}
