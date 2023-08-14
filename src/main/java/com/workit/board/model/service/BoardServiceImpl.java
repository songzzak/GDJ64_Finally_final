package com.workit.board.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.board.model.dao.BoardDao;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;
import com.workit.chatroom.model.dto.AttachedFile;

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
	public List<Notice> selectNoticeAll(Map<String, Object> map) {
		return dao.selectNoticeAll(session,map);
	}

	@Override
	public int selectNoticeCount(Map<String, Object> map) {
		return dao.selectNoticeCount(session,map);
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

	@Override
	public int insertNotice(Map<String, Object> map) {
		return dao.insertNotice(session, map);
	}

	@Override
	public int updateNotice(Map<String, Object> map) {
		return dao.updateNotice(session, map);
	}

	@Override
	public int deleteNotice(int commentNo) {
		return dao.deleteNotice(session,commentNo);
	}

	@Override
	public int insertAttachedFile(Map<String, Object> fileMap) {
		return dao.insertAttachedFile(session, fileMap);
	}

	@Override
	public int insertNoticeFile() {
		return dao.insertNoticeFile(session);
	}

	@Override
	public List<AttachedFile> selectFileListByNo(int no) {
		return dao.selectFileListByNo(session, no);
	}

	@Override
	public AttachedFile selectFileById(int fileId) {
		return dao.selectFileById(session, fileId);
	}



}
