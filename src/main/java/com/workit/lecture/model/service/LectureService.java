package com.workit.lecture.model.service;

import java.util.List;
import java.util.Map;

import com.workit.lecture.model.dto.Lecture;
import com.workit.member.model.vo.MemberVO;

public interface LectureService {

	int insertLecture(Map<String, Object> params);

	List<Lecture> selectLectureAll(Map<String, Object> map);

	int selectLectureCount(Map<String, Object> params);

	List<MemberVO> selectTeacher();
}
