package com.workit.work.model.service;

import java.util.List;
import java.util.Map;

import com.workit.work.model.dto.Work;

public interface WorkService {
	int insertStartTime(Work w);

	Work selectStartTime(String memberId);

	int updateEndTime(Work w);

	Work selectEndTime(String memberId);

	int updateStatus(Work w);

	Work selectWeekTime(String memberId);

	Work selectMonthTime(String memberId);

	List<Work> monthWorkTime(Map<String, String> param);

	List<Work> selectDeptStatus(String memberId);

	List<Work> selectDeptWork(Map<String, String> param);

	List<Work> commuteList(Map<String, String> param);

	List<Work> overworkList(Map<String, String> param);

	Work monthTotalTime(Map<String, String> param);

	List<Work> selectDeptWeekList(Map<String, String> param);

	Work selectMember(String memberId);
}
