package com.workit.work.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.workit.work.model.dto.Work;
import com.workit.work.model.service.WorkService;

@Controller
public class WorkController {

	private WorkService service;

	@Autowired
	public WorkController(WorkService service) {
		this.service = service;
	}

	@RequestMapping("workTime.do")
	public String monthWorkTime(
			@RequestParam(required = false) Integer currentYear, 
            @RequestParam(required = false) Integer currentMonth,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		//HttpSession session = request.getSession();
//		Member m = (Member) session.getAttribute("loginUser");
//		String memberId = m.getmId();
		String memberId = "user01";
		 if (currentYear == null || currentMonth == null) {
	            Calendar cal = Calendar.getInstance();
	            currentYear = cal.get(Calendar.YEAR);
	            currentMonth = cal.get(Calendar.MONTH) + 1;
	            // 년월 정보를 Map에 담기
	            Map<String, Object> paramMap = new HashMap<>();
	            paramMap.put("memberId", memberId);
	            paramMap.put("currentYear", currentYear);//2023
	            paramMap.put("currentMonth", currentMonth);//8
	            //System.out.println(paramMap);
	            
	            List<Work> workList = service.getMonthWorkTime(paramMap);
	            // 뷰에 데이터 전달
	            model.addAttribute("workList", workList);
	            return "/work/workBoard";
	        }else {
	        	 // 년월 정보를 Map에 담기
	            Map<String, Object> paramMap = new HashMap<>();
	            paramMap.put("memberId", memberId);
	            paramMap.put("currentYear", currentYear);
	            paramMap.put("currentMonth", currentMonth);
	            List<Work> workList = service.getMonthWorkTime(paramMap);
	            //System.out.println(workList);
	        	Gson gson = new Gson();
	        	String json = gson.toJson(workList);
	        	response.setContentType("application/json");
	        	response.setCharacterEncoding("UTF-8");
	        	response.getWriter().write(json);
	        }
		 return null;
	}

}
