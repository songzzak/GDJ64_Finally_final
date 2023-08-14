package com.workit.board.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.board.model.dao.BoardDao;
import com.workit.board.model.dto.Board;
import com.workit.board.model.dto.BoardComment;
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

	//	공지사항
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
	public Notice selectPrevNotice(int no) {
		return dao.selectPrevNotice(session,no);
	}

	@Override
	public Notice selectNextNotice(int no) {
		return dao.selectNextNotice(session,no);
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

	@Override
	public int updateViewCount(int no) {
		return dao.updateViewCount(session,no);
	}

	//	부서게시판
	@Override
	public List<Board> selectBoardAll(Map<String, Object> params) {
		return dao.selectBoardAll(session, params);
	}

	@Override
	public int selectBoardCount(Map<String, Object> params) {
		return dao.selectBoardCount(session, params);
	}

	@Override
	public Board selectBoardByNo(int no) {
		return dao.selectBoardByNo(session, no);
	}

	@Override
	public List<BoardComment> selectBoardCommentList(int no) {
		return dao.selectBoardCommentList(session, no);
	}

	@Override
	public int insertBoardComment(Map<String, Object> map) {
		return dao.insertBoardComment(session, map);
	}

	@Override
	public int deleteBoardComment(int commentNo) {
		return dao.deleteBoardComment(session, commentNo);
	}

	@Override
	public int updateBoardComment(Map<String, Object> map) {
		return dao.updateBoardComment(session, map);
	}

	@Override
	public int insertBoard(Map<String, Object> map) {
		return dao.insertBoard(session, map);
	}

	@Override
	public int updateBoard(Map<String, Object> map) {
		return dao.updateBoard(session, map);
	}

	@Override
	public int deleteBoard(int commentNo) {
		return dao.deleteBoard(session, commentNo);
	}

	@Override
	public int insertBoardFile() {
		return dao.insertBoardFile(session);
	}

	@Override
	public int updateBoardViewCount(int no) {
		return dao.updateBoardViewCount(session, no);
	}

	@Override
	public List<AttachedFile> selectFileListByBoardNo(int no) {
		return dao.selectFileListByBoardNo(session, no);
	}




}
