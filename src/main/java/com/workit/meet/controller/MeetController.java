package com.workit.meet.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.workit.meet.model.dto.Meet;
import com.workit.meet.model.service.MeetService;
import com.workit.member.model.vo.MemberVO;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;

@Controller
@RequestMapping("/meet")
public class MeetController {

	private MeetService service;
	
	@Autowired
	public MeetController(MeetService service) {
		this.service = service;
	}
	
	@GetMapping("/meetList")
	public String selectMeetAll() {

	    return "meet/meetList";
	}
	
	@GetMapping(value = "/meetData")
	@ResponseBody
	public List<Map<String, Object>> data(@RequestParam(value = "room",defaultValue = "1")int room) throws ParseException {
		List<Meet> meets = service.getMeetingsByRoomId(room);
	    //System.out.println(meets);
	    JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();
	    
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        Date currentDate = new Date();

        for (Meet meet : meets) {
        	String titleTime = timeFormat.format(meet.getStartTime()) + "-" + timeFormat.format(meet.getEndTime());
            String title = titleTime + " " + meet.getMember().getDept().getDeptName() + " " + meet.getMember().getMemberName();
            String popupTitle = meet.getTitle();
            String date = dateFormat.format(meet.getStartTime());
            String time = timeFormat.format(meet.getStartTime()) + "-" + timeFormat.format(meet.getEndTime());
            String memberInfo = meet.getMember().getDept().getDeptName() + " " + meet.getMember().getMemberName() + " " + meet.getMember().getJob().getJobName();
            String description = meet.getDescription();
            
            HashMap<String, Object> event = new HashMap<>();
            event.put("title", title);
            event.put("popupTitle", popupTitle);
            event.put("date", date);
            event.put("time", time);
            event.put("memberInfo", memberInfo);
            event.put("description", description);
            event.put("start", sdf.format(meet.getStartTime()).replace(" ", "T"));
            event.put("end", sdf.format(meet.getEndTime()).replace(" ", "T"));
            event.put("borderColor", currentDate.after(meet.getEndTime()) ? "red" : "green");
            
            jsonObj = new JSONObject(event);
            jsonArr.add(jsonObj);
        }

        //System.out.println(jsonArr);
        return jsonArr;
	}


	@GetMapping("/meetForm")
	public String insertMeet() {
		return "meet/meetForm";
	}
	
	@PostMapping("/checkOverlap")
	@ResponseBody
	public boolean checkOverlap(@RequestParam("roomId") int roomId,
	                            @RequestParam("eventDate") String eventDate,
	                            @RequestParam("startTime") String startTime,
	                            @RequestParam("endTime") String endTime) throws ParseException {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	    Date start = sdf.parse(eventDate + " " + startTime);
	    Date end = sdf.parse(eventDate + " " + endTime);
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("roomId", roomId);
	    paramMap.put("start", start);
	    paramMap.put("end", end);
	    List<Meet> meetings = service.getMeetingsByRoomIdAndDate(paramMap);
	    return meetings.isEmpty();
	}

	@PostMapping("/insertMeet")
	public String insertMeet(
	    @RequestParam("roomId") int roomId, 
	    @RequestParam("title") String title, 
	    @RequestParam("description") String description, 
	    @RequestParam("eventDate") String eventDateString, 
	    @RequestParam("startTime") String startTimeString, 
	    @RequestParam("endTime") String endTimeString, 
	    HttpSession session) {

	    Map<String, Object> paramMap = new HashMap<>();
	    String memberId = ((MemberVO) session.getAttribute("loginMember")).getMemberId();
	    
	    try {
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        String startTimeStr = eventDateString + " " + startTimeString + ":00"; 
	        String endTimeStr = eventDateString + " " + endTimeString + ":00";

	        Timestamp startTimestamp = Timestamp.valueOf(startTimeStr);
	        Timestamp endTimestamp = Timestamp.valueOf(endTimeStr);

	        paramMap.put("memberId", memberId);
	        paramMap.put("roomId", roomId);
	        paramMap.put("title", title);
	        paramMap.put("description", description);
	        paramMap.put("eventDate", eventDateString);
	        paramMap.put("startTime", startTimestamp);
	        paramMap.put("endTime", endTimestamp);
	        System.out.println(paramMap);
	        service.insertMeet(paramMap);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "redirect:/meet/meetList"; 
	}



	@GetMapping("/myMeetList")
	public String selectMeetById() {
		return "meet/myMeetList";
	}
}
