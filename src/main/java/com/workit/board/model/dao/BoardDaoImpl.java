package com.workit.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.board.model.dto.Notice;
import com.workit.board.model.dto.NoticeComment;
import com.workit.chatroom.model.dto.AttachedFile;

@Repository
public class BoardDaoImpl implements BoardDao {


	@Override
	public List<Notice> selectNoticeAll(SqlSessionTemplate session, Map<String, Object> map) {
		int cPage=(int)map.get("cPage");
		int numPerpage=(int)map.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("board.selectNoticeAll",map,rb);
	}

	@Override
	public int selectNoticeCount(SqlSessionTemplate session, Map<String, Object> map) {
		return session.selectOne("board.selectNoticeCount",map);
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

	@Override
	public int insertNotice(SqlSessionTemplate session, Map<String, Object> map) {
		return session.insert("insertNotice",map);
	}

	@Override
	public int updateNotice(SqlSessionTemplate session, Map<String, Object> map) {
		return session.update("board.updateNotice",map);
	}

	@Override
	public int deleteNotice(SqlSessionTemplate session, int commentNo) {
		return session.delete("board.deleteNotice",commentNo);
	}

	@Override
	public int insertAttachedFile(SqlSessionTemplate session, Map<String, Object> fileMap) {
		return session.insert("board.insertAttachedFile",fileMap);
	}

	@Override
	public int insertNoticeFile(SqlSessionTemplate session) {
		return session.insert("board.insertNoticeFile");
	}

	@Override
	public List<AttachedFile> selectFileListByNo(SqlSessionTemplate session, int no) {
		return session.selectList("board.selectFileListByNo",no);
	}

	@Override
	public AttachedFile selectFileById(SqlSessionTemplate session, int fileId) {
		return session.selectOne("board.selectFileById",fileId);
	}

	@Override
	public int updateViewCount(SqlSessionTemplate session, int no) {
		return session.update("board.updateViewCount",no);
	}

}
