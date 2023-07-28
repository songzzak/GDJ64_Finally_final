package com.workit.work.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.workit.work.model.dto.Work;
import com.workit.work.model.service.WorkService;

@Controller
public class WorkController {

	private WorkService service;

	@Autowired
	public WorkController(WorkService service) {
		this.service = service;
	}

	@RequestMapping("monthWorkTime.do")
	public void monthWorkTime(@RequestParam("currentYearMonth") String currentYearMonth,
			@RequestParam("currentYear") int currentYear, @RequestParam("currentMonth") int currentMonth,
			@RequestParam("weekSeq") int weekSeq, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		HttpSession session = request.getSession();
//		Member m = (Member) session.getAttribute("loginUser");
//		String id = m.getmId();
		String id = "test";
		Map<String, String> map = new HashMap<>();
		map.put("currentYearMonth", currentYearMonth);
		map.put("id", id);
		System.out.println(currentYearMonth);
		List<Work> mwList = service.monthWorkTime(map);
		System.out.println("시작");
		System.out.println("한달 워크타임:" + mwList);

//		for (int i = 0; i < mwList.size(); i++) {
//			if (mwList.get(i).getStrGapTime().equals("::")) {
//				mwList.get(i).setStrGapTime("");
//			}
//			if (mwList.get(i).getStrOverTime().equals("::")) {
//				mwList.get(i).setStrOverTime("");
//			}
//		}
		model.addAttribute("mwList", mwList);
		
		 Gson gson = new Gson();

//		GsonBuilder gb = new GsonBuilder();
//		gb.setDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
//
//		Gson gson = gb.create();
		try {
			gson.toJson(mwList, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}

}
