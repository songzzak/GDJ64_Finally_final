package com.workit.approve.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.model.dto.ApproveAttach;
import com.workit.approve.model.dto.Time;
import com.workit.approve.model.service.ApproveService;
import com.workit.employee.service.EmployeeService;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Member;

@Controller
@RequestMapping("/approve")
public class ApproveController {
	@Autowired
	private ApproveService service;
	
	@Autowired
	private EmployeeService eservice;
	
	@RequestMapping("/extendsView.do") // 연장근무신청서 페이지로 이동
	public String extendsView(Model m) {
		  LocalDate now = LocalDate.now();
	      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	      String time = now.format(formatter);
	    
	    List<Department> deps = eservice.selectDept();
		/* List<Member> members = service.selectAllMember(); */
	 
	    
		/* m.addAttribute("members",members); */
	    m.addAttribute("deps",deps);
		m.addAttribute("time",time); // 현재날짜 전달
		return "approve/extends-app";
	}
	
	@RequestMapping("/attendanceView.do")  // 근태신청서 페이지로 이동
	public String attendacneView(Model m) {
		  LocalDate now = LocalDate.now();
	      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	      String time = now.format(formatter);
		    List<Department> deps = eservice.selectDept();
			/* List<Member> members = service.selectAllMember(); */
		 
		    
			/* m.addAttribute("members",members); */
		    m.addAttribute("deps",deps);

		m.addAttribute("time",time); // 현재날짜 전달
		return "approve/attendance-app";
	}
	
	@RequestMapping("/expenditureView.do")  // 지출결의서 페이지로 이동
	public String expenditureView(Model m) {
		  LocalDate now = LocalDate.now();
	      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	      String time = now.format(formatter);
		    List<Department> deps = eservice.selectDept();
			/* List<Member> members = service.selectAllMember(); */
		 
		    
			/* m.addAttribute("members",members); */
		    m.addAttribute("deps",deps);

		m.addAttribute("time",time); // 현재날짜 전달
		return "approve/expenditure-app";
	}
	

	@RequestMapping("/waitingApprove.do") // 결재대기문서로 이동
	public String selectWaitingApprove(Model m,@RequestParam(value="mId") String mId) {
		List<Approve> apps = service.selectAllWaitingApprove(mId);
		for(Approve app : apps) {
			System.out.println(app);
		}
		m.addAttribute("apps", apps);

		System.out.println(apps);
		return "approve/waiting-approve";
	}
	
	@PostMapping("/changeDep.do") // 결재선에서 부서클릭시 맞는 부서들 출력
	@ResponseBody // 비동기식으로 받기위해서 @ResponseBody 어노테이션을 사용해야함
	public List<Member> changeDep(String deptName){ // 선택한 부서에 맞는 사원들 리스트로 반환
		List<Member> m = service.changeDep(deptName);
		System.out.println(m);
		return m;
	}
	
	
	@PostMapping("/printMember.do")
	@ResponseBody // 비동기식으로 받기위해서 @ResponseBody 어노테이션을 사용해야함
	// 배열로 받으려면 @RequestParam(value="키값[]") 아무변수명[]을 받아주면됨
	public List<Member> printMember(@RequestParam(value="memberId[]") String[] ListData){ // 선택한 부서에 맞는 사원들 리스트로 반환
		
		List<Member> members = new ArrayList<Member>();
		
		for(int i=0; i<ListData.length; i++) {
			members.add(service.printMember(ListData[i])); 
		}
		
		return members;
		/* return service.printMember(memberId); */
	}
	
	
	
	@RequestMapping("/insertDraft.do")
	public String insertDraft(String memberId, String writeTime, String startDate, String endDate, String startTime, String endTime, 
			String content, String title, String approveKind, String geuntae,
			String paraApp[], String paraRefer[], 
			MultipartFile upFile, HttpSession session) throws ParseException{
		
		System.out.println(approveKind);
		System.out.println(geuntae);
		
		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); //파일 저장 경로
        
		if(geuntae == null) { // 근태신청서가 아닌경우
			Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(memberId).approveKind(approveKind).build(); 
			int result = service.insertApprove(ap); // 기안서 테이블 생성 

		}else {  // 연장근무신청서의 경우
			Approve ap = Approve.builder().approveTitle(title).approveContent(content).memberId(memberId).approveKind(geuntae).build();
			int result = service.insertApprove(ap); // 기안서 테이블 생성 
		}
			

		
		if(endDate == null) {  // endDate가 null일경우 -> 연장근무신청서, 반차, 외출의 경우(한 날짜에서 시작시간과 끝시간을 고름)
			startTime = startDate+" "+startTime; 
			endTime = startDate+" "+endTime;
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
			Date date = df.parse(startTime); 
			long stime = date.getTime();
			
			Date date2 = df.parse(endTime); 
			long etime = date2.getTime();
			
			Timestamp st = new Timestamp(stime); Timestamp et = new Timestamp(etime);
			
			Time t = Time.builder().startTime(st).endTime(et).build();
			
			int result2 = service.insertTime(t); 			
		}else {  // -> 연차, 보건, 경조의 경우
			startTime = startDate+" "+"00:00"; 
			endTime = startDate+" "+"00:00";
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
			Date date = df.parse(startTime); 
			long stime = date.getTime();
			
			Date date2 = df.parse(endTime); 
			long etime = date2.getTime();
			
			System.out.println(stime);
			System.out.println(etime);
			
			Timestamp st = new Timestamp(stime); Timestamp et = new Timestamp(etime);
			
			Time t = Time.builder().startTime(st).endTime(et).build();
			
			int result2 = service.insertTime(t); 
		}
	
		 
		
	/*	if (!upFile.getOriginalFilename().equals("")) {  // 첨부파일 추가했을경우
			String oriName=upFile.getOriginalFilename(); // 원본이름
			Date today = new Date(System.currentTimeMillis());
			String ext=oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random+ext;
			try {
				upFile.transferTo(new File(path + rename));
				ApproveAttach aa = ApproveAttach.builder().oriName(oriName).saveName(rename).build();
				int result3 = service.insertApproveAttach(aa);  // 첨부파일 테이블 생성
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		int appSuccess = 0;
		for(int i=0; i<paraApp.length; i++) {
			Map<String,Object> param=new HashMap<>();
			param.put("memberId", paraApp[i]);
			param.put("order", i+1);
			int result4 = service.insertApproveLine(param); // 결재선 테이블 추가
			if(result4 >= 1) { //결재선테이블 추가 성공할때마다 1증가
				appSuccess+=1;
			}
		}
		System.out.println("결재선 테이블 성공횟수 = "+appSuccess);
		
		
		int referSuccess = 0;
		for(int i=0; i<paraRefer.length; i++) {
			Map<String,Object> param=new HashMap<>();
			param.put("memberId", paraRefer[i]);
			int result5 = service.insertReferLine(param); // 결재선 테이블 추가
			if(result5 >= 1) { //결재선테이블 추가 성공할때마다 1증가
				referSuccess+=1;
			}
		}
		System.out.println("참조선 테이블 성공횟수 = "+referSuccess); */ 
		
		
		
		
		return "redirect:/";
	}
	
	
}
