package com.workit.employee.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.workit.employee.service.EmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	private EmployeeService service;
	public EmployeeController(EmployeeService service) {
		this.service=service;
	}
	@GetMapping("/enroll")
	public String enrollView(Model model) {
		model.addAttribute("depts",service.selectDept());
		model.addAttribute("jobs",service.selectJob());
		return "employee/enrollEmp";
	}
	
	@PostMapping("/enroll")
	public String enrollMember(Model model, @RequestParam Map<String,Object> param) {
		System.out.println(param.get("enroll-date"));
		return "redirect:/";
	}
}
