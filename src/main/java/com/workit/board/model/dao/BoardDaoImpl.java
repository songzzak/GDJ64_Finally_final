package com.workit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;

@Repository
public class BoardDaoImpl implements BoardDao {


	@Override
	public List<Notice> selectNoticeAll(SqlSessionTemplate session, Map<String, Integer> map) {
		int cPage=(int)map.get("cPage");
		int numPerpage=(int)map.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("board.selectNoticeAll","",rb);
	}

	@Override
	public int selectNoticeCount(SqlSessionTemplate session) {
		return session.selectOne("board.selectNoticeCount");
	}

	@Override
	public Notice selectNoticeByNo(SqlSessionTemplate session, int no) {
		return session.selectOne("board.selectNoticeByNo",no);
	}

	@Override
	public int insertNoticeComment(SqlSessionTemplate session, Map<String, Object> map) {
		return session.insert("board.insertNoticeComment",map);
	}

	@Override
	public List<NoticeComment> selectCommentList(SqlSessionTemplate session, int no) {
		return session.selectList("board.selectCommentList",no);
	}

	@Override
	public int deleteNoticeComment(SqlSessionTemplate session, int commentNo) {
		return session.delete("board.deleteNoticeComment",commentNo);
	}

	@Override
	public int updateNoticeComment(SqlSessionTemplate session, Map<String, Object> map) {
		return session.update("board.updateNoticeComment",map);
	}

}
