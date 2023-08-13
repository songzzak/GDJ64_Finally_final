package com.workit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;

public interface BoardDao {

	List<Notice> selectNoticeAll(SqlSessionTemplate session, Map<String, Object> map);

	int selectNoticeCount(SqlSessionTemplate session, Map<String, Object> map);

	Notice selectNoticeByNo(SqlSessionTemplate session, int no);

	int insertNoticeComment(SqlSessionTemplate session, Map<String, Object> map);

	List<NoticeComment> selectCommentList(SqlSessionTemplate session, int no);

	int deleteNoticeComment(SqlSessionTemplate session, int commentNo);

	int updateNoticeComment(SqlSessionTemplate session, Map<String, Object> map);

	int insertNotice(SqlSessionTemplate session, Map<String, Object> map);

	int updateNotice(SqlSessionTemplate session, Map<String, Object> map);

	int deleteNotice(SqlSessionTemplate session, int commentNo);

}
