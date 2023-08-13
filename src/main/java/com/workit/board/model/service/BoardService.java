package com.workit.board.model.service;

import java.util.List;
import java.util.Map;

import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;

public interface BoardService {
	
	//공지사항 목록
	List<Notice> selectNoticeAll(Map<String, Integer> map);
	int selectNoticeCount();
	//공지사항 화면 출력
	Notice selectNoticeByNo(int no);
	List<NoticeComment> selectCommentList(int no);
	
	//공지사항 댓글
	int insertNoticeComment(Map<String, Object> map);
	int deleteNoticeComment(int commentNo);
	int updateNoticeComment(Map<String, Object> map);

}
