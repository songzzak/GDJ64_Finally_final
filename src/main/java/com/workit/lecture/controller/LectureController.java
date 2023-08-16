package com.workit.lecture.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.workit.common.Pagenation;
import com.workit.lecture.model.dto.Lecture;
import com.workit.lecture.model.service.LectureService;

@Controller
@RequestMapping("/lecture")
public class LectureController {

	private LectureService service;
	
	public LectureController(LectureService service) {
		this.service = service;
	}
	
	@GetMapping("/lectureList")
	public String selectLectureAll(Model model,@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="searchType", required=false) String searchType,
            @RequestParam(value="searchKeyword", required=false) String searchKeyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("cPage", cPage);
		params.put("numPerpage", 5);
		if(searchType != null) {
		    params.put("searchType", searchType);
		}
		if(searchKeyword != null) {
		    params.put("searchKeyword", searchKeyword);
		}

		List<Lecture> lectureList = service.selectLectureAll(params);
	
		 int totalData=service.selectLectureCount(params);
		model.addAttribute("lectureList", lectureList);
		model.addAttribute("pageBar",Pagenation.getPage(cPage,5,totalData,"/lecture/lectureList"));
		
		return "/lecture/lectureList";
	}
	
}
