package com.workit.lecture.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.workit.lecture.model.dto.Lecture;

public interface LectureService {

	List<Lecture> selectLectureAll(Map<String, Object> map);

	int selectLectureCount(Map<String, Object> params);
}
