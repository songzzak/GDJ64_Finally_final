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

	@RequestMapping("workTime.do")
	public void monthWorkTime(
			@RequestParam("currentYear") int currentYear, @RequestParam("currentMonth") int currentMonth,
			HttpServletRequest request, HttpServletResponse response,
			Model model) throws IOException {
		//HttpSession session = request.getSession();
//		Member m = (Member) session.getAttribute("loginUser");
//		String id = m.getmId();
		String memberId = "user01";
		// 년월 정보를 Map에 담기
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("currentYear", currentYear);
        paramMap.put("currentMonth", currentMonth);

        // 서비스를 호출하여 해당 월의 근무 데이터 가져오기
        List<Work> workList = service.getMonthWorkTime(paramMap);

        // 뷰에 데이터 전달
        model.addAttribute("workList", workList);

        // 여기서는 해당 데이터를 JSON 형식으로 응답하는 것으로 보이기 때문에, 아래와 같이 작성할 수 있습니다.
        // Gson 라이브러리를 사용하여 List<Work>를 JSON 형식으로 변환하여 응답합니다.
         Gson gson = new Gson();
         String jsonData = gson.toJson(workList);
         response.setContentType("application/json");
         response.setCharacterEncoding("UTF-8");
         response.getWriter().write(jsonData);
	}

}
