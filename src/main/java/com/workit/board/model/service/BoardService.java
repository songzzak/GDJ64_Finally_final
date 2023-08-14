package com.workit.board.model.service;

import java.util.List;
import java.util.Map;

import com.workit.board.model.dto.Board;
import com.workit.board.model.dto.BoardComment;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;
import com.workit.chatroom.model.dto.AttachedFile;

public interface BoardService {
	
	//공지사항 목록
	List<Notice> selectNoticeAll(Map<String, Object> params);
	int selectNoticeCount(Map<String, Object> params);
	//공지사항 화면 출력
	Notice selectNoticeByNo(int no);
	List<NoticeComment> selectCommentList(int no);
	
	//공지사항 댓글
	int insertNoticeComment(Map<String, Object> map);
	int deleteNoticeComment(int commentNo);
	int updateNoticeComment(Map<String, Object> map);
	//공지사항 등록
	int insertNotice(Map<String, Object> map);
	int updateNotice(Map<String, Object> map);
	int deleteNotice(int commentNo);
	//첨부파일 등록
	int insertAttachedFile(Map<String, Object> fileMap);
	int insertNoticeFile();
	//첨부파일 조회
	List<AttachedFile> selectFileListByNo(int no);
	AttachedFile selectFileById(int fileId);
	//조회수 증가
	int updateViewCount(int no);

	//게시판 목록
	List<Board> selectBoardAll(Map<String, Object> params);
	int selectBoardCount(Map<String, Object> params);
	//게시판 화면 출력
	Board selectBoardByNo(int no);
	List<BoardComment> selectBoardCommentList(int no);
	
	//게시판 댓글
	int insertBoardComment(Map<String, Object> map);
	int deleteBoardComment(int commentNo);
	int updateBoardComment(Map<String, Object> map);
	//게시판 등록
	int insertBoard(Map<String, Object> map);
	int updateBoard(Map<String, Object> map);
	int deleteBoard(int commentNo);
	//첨부파일 등록
	int insertBoardFile();

}
