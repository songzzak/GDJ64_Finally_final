package com.workit.employee.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String selectMemberList(Model model) {
		model.addAttribute("members",service.selectMemberAll());
		return "employee/listEmp";
	}
}
