package com.workit.approve.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

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
	public Member printMember(String memberId){ // 선택한 부서에 맞는 사원들 리스트로 반환
		return service.printMember(memberId);
	}
	
	
	
	@RequestMapping("/insertDraft.do")
	public String insertDraft(String memberId, String writeTime, String extendWorkDate, String startTime, String endTime, 
			String content, String title, String approveKind, MultipartFile upFile, HttpSession session) throws ParseException{
		

		String path = session.getServletContext().getRealPath("/resources/upload/approve/"); //파일 저장 경로
        
		
        

		Approve ap = Approve.builder().approveTitle(title).approveContent(content)
				.memberId(memberId).approveKind(approveKind).build(); 
		int result = service.insertApprove(ap); // 기안서 테이블 생성 System.out.println(result);


		 startTime = extendWorkDate+" "+startTime; 
		 endTime = extendWorkDate+" "+endTime;
		 DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
		 Date date = df.parse(startTime); 
		 long stime = date.getTime();

		 Date date2 = df.parse(endTime); 
		 long etime = date2.getTime();
		
		 Timestamp st = new Timestamp(stime); Timestamp et = new Timestamp(etime);
		 System.out.println(st.getClass().getName()); System.out.println(st);
		 
		 System.out.println(et.getClass().getName()); System.out.println(et); 
		 Time t = Time.builder().startTime(st).endTime(et).build();
		
		 int result2 = service.insertTime(t); System.out.println(result2);

		
		if (!upFile.getOriginalFilename().equals("")) {  // 첨부파일 추가했을경우
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
		
		
		
		return "redirect:/";
	}
	
	
}
