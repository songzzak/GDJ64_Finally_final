package com.workit.work.model.service;

import java.util.List;
import java.util.Map;

import com.workit.work.model.dto.Work;

public interface WorkService {
	
	// 월별 근무 정보 가져오기
	List<Work> getMonthWorkTime(Map<String, Object> paramMap);
	
	//출근시간 등록
	int insertStartWorkTime(Work w);
	//퇴근시간 등록
	int updateEndWorkTime(Work w);

	//출근여부확인
	boolean isWorkDataRegisteredForDate(Map<String, String> mapParam);
	//퇴근여부확인
	boolean isCheckOutRegisteredForDate(Map<String, String> mapParam);

	//오늘 출퇴근 정보
	Work selectWorkByDateAndMemberId(Map<String, Object> paramMap);
	
	//지각계카운트
	int lateCount(Map<String, Object> paramMap);
	//조퇴계카운트
	int earlyLeaveCount(Map<String, Object> paramMap);



	
}
