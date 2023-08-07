package com.workit.work.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.workit.work.model.dto.Work;
import com.workit.work.model.service.WorkService;

@Controller
@RequestMapping("/work")
public class WorkController {

	private WorkService service;

	@Autowired
	public WorkController(WorkService service) {
		this.service = service;
	}

	@GetMapping("/workTime")
	public String monthWorkTime(
			@RequestParam(required = false) Integer currentYear, 
            @RequestParam(required = false) Integer currentMonth,
			HttpServletRequest request, HttpServletResponse response, Model model) throws IOException{
		//HttpSession session = request.getSession();
//		Member m = (Member) session.getAttribute("loginUser");
//		String memberId = m.getmId();
		String memberId = "user01";
		 // 오늘의 날짜 정보를 가져옴
	    LocalDate today = LocalDate.now();//2023-08-07

	    Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("today", today);
	    // 오늘의 근태 정보 조회
	    Work todayWork = service.selectWorkByDateAndMemberId(paramMap);
	    //System.out.println(todayWork);
	    model.addAttribute("todayWork", todayWork); // 오늘의 근태 정보를 모델에 추가
		
		 if (currentYear == null || currentMonth == null) {
	            Calendar cal = Calendar.getInstance();
	            currentYear = cal.get(Calendar.YEAR);
	            currentMonth = cal.get(Calendar.MONTH) + 1;
	            // 년월 정보를 Map에 담기
	            paramMap.put("currentYear", currentYear);//2023
	            paramMap.put("currentMonth", currentMonth);//8
	            //System.out.println(paramMap);
	            
	            List<Work> workList = service.getMonthWorkTime(paramMap);
	            int lateCount = service.lateCount(paramMap);
	            int earlyLeaveCount = service.earlyLeaveCount(paramMap);
	            //System.out.println(workList);
	            // 뷰에 데이터 전달
	            model.addAttribute("workList", workList);
	            model.addAttribute("lateCount",lateCount);
	            model.addAttribute("earlyLeaveCount", earlyLeaveCount);
	            return "/work/workBoard";
	        }else {
	            paramMap.put("currentYear", currentYear);
	            paramMap.put("currentMonth", currentMonth);
	            List<Work> workList = service.getMonthWorkTime(paramMap);
	            int lateCount = service.lateCount(paramMap);
	            int earlyLeaveCount = service.earlyLeaveCount(paramMap);
	            Gson gson = new Gson();

	            Map<String, Object> data = new HashMap<>();
	            data.put("workList", workList);
	            data.put("lateCount", lateCount);
	            data.put("earlyLeaveCount", earlyLeaveCount);

	            String json = gson.toJson(data);
	            response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
	            response.getWriter().write(json);
	        }
		 return null;
	}

	
	 @PostMapping("/workStart")
	 @ResponseBody
	    public Map<String, String> startWork(@RequestParam("workStartTime") String workStartTime) {
	        Map<String, String> result = new HashMap<>();
	        
	        // 임시 사용자 ID
	        String memberId = "user01";
	        Timestamp currentTimestamp = null;
	        String workStatus = null;
	        try {
	        	SimpleDateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	            utcFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // UTC 시간대로 설정
	            java.util.Date parsedDate = utcFormat.parse(workStartTime);  // UTC 기준 java.util.Date로 변경

	            SimpleDateFormat seoulFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
	            seoulFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul")); // 서울 시간대로 설정
	            String seoulTime = seoulFormat.format(parsedDate); // 서울 시간대 기준 문자열로 변환
	            parsedDate = seoulFormat.parse(seoulTime); // 다시 Date 객체로 변환

	            currentTimestamp = new Timestamp(parsedDate.getTime());
	            // 시간을 24시간 형식으로 구해서 9시 이후인지 체크
	            LocalDateTime currentTime = currentTimestamp.toLocalDateTime();
	            int hour = currentTime.getHour();
	            workStatus = (hour >= 9) ? "지각" : "정상출근";
	        } catch (ParseException e) {
	            e.printStackTrace();
	            result.put("status", "error");
	            result.put("msg", "잘못된 시간 형식입니다.");
	            return result;
	        }
	        
	        Work w = Work.builder()
	                        .memberId(memberId)
	                        .workStart(currentTimestamp)
	                        .workStatus(workStatus)
	                        .build();
	        
	        if(service.insertStartWorkTime(w) > 0) {
	            result.put("status", "success");
	            result.put("msg", "출근 시간이 저장되었습니다.");
	        } else {
	            result.put("status", "error");
	            result.put("msg", "저장 중 오류가 발생했습니다.");
	        }

	        return result;
	    }
	 
	 @PostMapping("/workEnd")
	 @ResponseBody
	 public Map<String, String> endWork(@RequestParam("workEndTime") String workEndTime) {
	      Map<String, String> result = new HashMap<>();

	      // 임시 사용자 ID
	      String memberId = "user01";
	      Timestamp currentTimestamp = null;
	      String workStatus = "지각";
	      try {
	          SimpleDateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	          utcFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // UTC 시간대로 설정
	          java.util.Date parsedDate = utcFormat.parse(workEndTime);  // UTC 기준 java.util.Date로 변경

	          currentTimestamp = new Timestamp(parsedDate.getTime());
	          // 시간을 24시간 형식으로 구해서 18시 이전인지 체크
	          LocalDateTime currentTime = currentTimestamp.toLocalDateTime();
	          int hour = currentTime.getHour();
	          
	          // 해당 날짜에 대한 근무데이터
	          LocalDate today = LocalDate.now();//2023-08-07
	          Map<String, Object> paramMap = new HashMap<>();
	          paramMap.put("memberId", memberId);
	          paramMap.put("today", today);
	          Work todayWork = service.selectWorkByDateAndMemberId(paramMap);
	          System.out.println(todayWork);

	          // 작업 상태가 지각이 아닌 경우에만 상태를 재설정
	          if (todayWork.getWorkStatus().equals("정상출근")) {
	              workStatus = (hour < 18) ? "조퇴" : "정상출근";
	          } else {
	              workStatus = todayWork.getWorkStatus();
	          }

	          Work w = Work.builder()
	                       .memberId(memberId)
	                       .workEnd(currentTimestamp)
	                       .workStatus(workStatus)
	                       .build();

	          if(service.updateEndWorkTime(w) > 0) {
	              result.put("status", "success");
	              result.put("msg", "퇴근 시간이 저장되었습니다.");
	          } else {
	              result.put("status", "error");
	              result.put("msg", "저장 중 오류가 발생했습니다.");
	          }
	      } catch (ParseException e) {
	          e.printStackTrace();
	          result.put("status", "error");
	          result.put("msg", "잘못된 시간 형식입니다.");
	      }
	      return result;
	 }





	 @GetMapping("/checkTodayWork")
	 @ResponseBody
	 public Map<String, Boolean> checkTodayWork(@RequestParam("date") String workDate) {
	     // 임시 사용자 ID
	     String memberId = "user01";
	     Map<String, String> mapParam = new HashMap<>();
	     mapParam.put("memberId", memberId);
	     mapParam.put("workDate", workDate);
	     //System.out.println(mapParam);
	     Map<String, Boolean> result = new HashMap<>();
	     boolean alreadyRegistered = service.isWorkDataRegisteredForDate(mapParam);
	     boolean alreadyCheckedOut = service.isCheckOutRegisteredForDate(mapParam);
	    //System.out.println(alreadyRegistered);
	     result.put("alreadyRegistered", alreadyRegistered);
	     result.put("alreadyCheckedOut", alreadyCheckedOut);
	     return result;
	 }



	 	
	 	
}
