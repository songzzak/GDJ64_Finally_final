package com.workit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.workit.lecture.model.dto.Lecture;

@Repository
public class LectureDaoImpl implements LectureDao {

	@Override
	public List<Lecture> selectLectureAll(SqlSessionTemplate session, Map<String, Object> map) {
		int cPage=(int)map.get("cPage");
		int numPerpage=(int)map.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("lecture.selectLectureAll",map,rb);
	}

	@Override
	public int selectLectureCount(SqlSessionTemplate session, Map<String, Object> map) {
		return session.selectOne("lecture.selectLectureCount",map);
	}

	
	
}
