package com.workit.employee.controller;

import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.workit.common.Pagenation;
import com.workit.employee.service.EmployeeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/employee")
@Slf4j
public class EmployeeController {
	@Autowired
	private EmployeeService service;
	
	//회원 생성 페이지 전환
	@GetMapping("/enroll")
	public String enrollView(Model model) {
		model.addAttribute("depts",service.selectDept());
		model.addAttribute("jobs",service.selectJob());
		return "employee/enrollEmp";
	}
	
	//회원 생성
	@PostMapping("/enroll")
	public String enrollMember(Model model, @RequestParam Map<String,Object> param) {
		service.insertEmployee(param);
		return "redirect:/";
	}
	
	@GetMapping("/list")
	public String selectMemberList(Model model, @RequestParam(value="cPage",defaultValue="1") int cPage) {
		model.addAttribute("members",service.selectMemberAll(Map.of("cPage",cPage,"numPerpage",15)));
		int totalData=service.selectMemberCount();
		model.addAttribute("pageBar",Pagenation.getPage(cPage,10,totalData,"/employee/list"));
		return "employee/listEmp";
	}
	
	@GetMapping("/dept")
	public String deptManageView(Model model,  @RequestParam(value="cPage",defaultValue="1") int cPage) {
		model.addAttribute("depts",service.selectDeptCount(Map.of("cPage",cPage,"numPerpage",10)));
		int totalData=service.selectGradeCount(Map.of("category","dept"));
		model.addAttribute("pageBar",Pagenation.getPage(cPage, 10, totalData, "/employee/manage"));
		return "employee/manageDept";
	}
	
	@GetMapping("/job")
	public String jobManageView(Model model,  @RequestParam(value="cPage",defaultValue="1") int cPage) {
		model.addAttribute("jobs",service.selectJobCount(Map.of("cPage",cPage,"numPerpage",10)));
		int totalData=service.selectGradeCount(Map.of("category","job"));
		model.addAttribute("pageBar",Pagenation.getPage(cPage, 10, totalData, "/employee/manage"));
		return "employee/manageJob";
	}
	
	@PostMapping("/dept")
	@ResponseBody
	public int insertDept(@RequestParam(value="deptName") String deptName) {
		return service.insertDept(deptName);
	}
	
	@DeleteMapping("/dept")
	@ResponseBody
	public int deleteDept(@RequestParam(value="deptCode") String deptCode) {
		return service.deleteDept(deptCode);
	}
	
	@PutMapping("/dept")
	@ResponseBody()
	public int updateDept(@RequestBody Map<String,Object> param) {
		return service.updateDept(param);
	}
}
