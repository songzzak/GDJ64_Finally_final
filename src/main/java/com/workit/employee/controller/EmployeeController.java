package com.workit.employee.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.workit.common.Pagenation;
import com.workit.employee.service.EmployeeService;
import com.workit.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/employee")
@Slf4j
public class EmployeeController {
	@Autowired
	private EmployeeService service;
	@Autowired
	private MemberService memberService;
	
	//회원 생성 페이지 전환
	@GetMapping("/enroll")
	public String enrollView(Model model) {
		model.addAttribute("depts",service.selectDept());
		model.addAttribute("jobs",service.selectJob());
		return "employee/enrollEmp";
	}
	
	//회원 생성
	@PostMapping("/enroll")
	public String enrollMember(@RequestParam Map<String,Object> param, Model model) {
		if (service.insertEmployee(param) > 0) {
			model.addAttribute("msg", "사원 생성되었습니다.");
			model.addAttribute("url", "/employee/enroll");
		} else {
			model.addAttribute("msg", "사원 생성 실패했습니다.");
			model.addAttribute("url", "/employee/enroll");
		}
		return "common/msg";
	}
	
	//회원 리스트
	@GetMapping("/list")
	public String selectMemberList(Model model, @RequestParam(value="cPage",defaultValue="1") int cPage) {
		model.addAttribute("members",service.selectMemberAll(Map.of("cPage",cPage,"numPerpage",15)));
		int totalData=service.selectMemberCount();
		model.addAttribute("pageBar",Pagenation.getPage(cPage,10,totalData,"/employee/list"));
		return "employee/listEmp";
	}
	
	//부서 관리 화면
	@GetMapping("/dept")
	public String deptManageView(Model model,  @RequestParam(value="cPage",defaultValue="1") int cPage) {
		model.addAttribute("depts",service.selectDeptCount(Map.of("cPage",cPage,"numPerpage",10)));
		int totalData=service.selectGradeCount(Map.of("category","dept"));
		model.addAttribute("pageBar",Pagenation.getPage(cPage, 10, totalData, "/employee/manage"));
		return "employee/manageDept";
	}
	
	//부서 추가
	@PostMapping("/dept")
	@ResponseBody
	public int insertDept(@RequestParam(value="deptName") String deptName) {
		return service.insertDept(deptName);
	}
	
	//부서 삭제
	@DeleteMapping("/dept")
	@ResponseBody
	public int deleteDept(@RequestParam(value="deptCode") String deptCode) {
		return service.deleteDept(deptCode);
	}
	
	//부서 수정
	@PutMapping("/dept")
	@ResponseBody()
	public int updateDept(@RequestBody Map<String,Object> param) {
		return service.updateDept(param);
	}
	
	//직책 관리 화면
	@GetMapping("/job")
	public String jobManageView(Model model, @RequestParam(value = "cPage", defaultValue = "1") int cPage) {
		model.addAttribute("jobs", service.selectJobCount(Map.of("cPage", cPage, "numPerpage", 10)));
		int totalData = service.selectGradeCount(Map.of("category", "job"));
		model.addAttribute("pageBar", Pagenation.getPage(cPage, 10, totalData, "/employee/manage"));
		return "employee/manageJob";
	}
	
	@GetMapping("/memberId")
	public String UpdateEmpView(Model model, @RequestParam(value="id") String id) {
		model.addAttribute("member",memberService.selectMemberByParam(Map.of("memberId",id)));
		model.addAttribute("depts",service.selectDept());
		model.addAttribute("jobs",service.selectJob());
		return "employee/updateEmp";
	}
	
	//사원 정보 수정
	@PostMapping("/memberId")
	public String updateMemberInfo(MultipartFile upFile, Model model, HttpSession session
			,@RequestParam Map<String,Object> param) {
		String path = session.getServletContext().getRealPath("/resources/upload/profile/"); //파일 저장 경로
		if (!upFile.getOriginalFilename().equals("")) { //파일이 있으면 실행
			String oriName=upFile.getOriginalFilename();
			Date today = new Date(System.currentTimeMillis());
			String ext=oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random+ext;
			try {
				upFile.transferTo(new File(path + rename));
			} catch (IOException e) {
				e.printStackTrace();
			}
			param.put("profileImg", rename);
		}else{
			//파일이 없으면 기본값 지정
			param.put("profileImg", param.get("profile"));
		}
		try {
			if (service.updateEmpInfo(param) > 0) {
				model.addAttribute("msg", "수정 완료되었습니다.");
				model.addAttribute("url", "/employee/memberId?id=" + param.get("memberId"));
				return "common/msg";
			}
		} catch (RuntimeException e) {
			// 입력 실패 시 업로드된 파일 삭제
			File delFile = new File((String) param.get("profile-img"));
			delFile.delete();
			model.addAttribute("msg", "수정 실패했습니다.");
			model.addAttribute("url", "/employee/memberId?id=" + param.get("memberId"));
		}
		return "common/msg";
	}
}
