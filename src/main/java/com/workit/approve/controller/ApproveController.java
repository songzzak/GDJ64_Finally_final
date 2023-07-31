package com.workit.approve.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/approve")
public class ApproveController {
	
	@RequestMapping("/approvePropView.do")
	public String approvePropView() {
		return "approve/expenditure-app";
	}
	
	@RequestMapping("/extendsView.do")
	public String extendsView() {
		return "approve/extends-app";
	}
	
	@RequestMapping("/attendanceView.do")
	public String attendacneView() {
		return "approve/attendance-app";
	}
	
	@RequestMapping("/expenditureView.do")
	public String expenditureView() {
		return "approve/expenditure-app";
	}
	
}
