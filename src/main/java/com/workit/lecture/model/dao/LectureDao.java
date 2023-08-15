package com.workit.lecture.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.lecture.model.dto.Lecture;

public interface LectureDao {

	List<Lecture> selectLectureAll(SqlSessionTemplate session, Map<String, Object> map);

	int selectLectureCount(SqlSessionTemplate session, Map<String, Object> map);
}
