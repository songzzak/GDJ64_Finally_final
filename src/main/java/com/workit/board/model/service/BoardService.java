package com.workit.board.model.service;

import java.util.List;
import java.util.Map;

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

}
