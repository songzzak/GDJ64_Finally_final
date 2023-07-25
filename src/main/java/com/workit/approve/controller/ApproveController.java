package com.workit.approve.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/approve")
public class ApproveController {
	
	@RequestMapping("/approvePropView.do")
	public String approvePropView() {
		return "approve/drafting_app";
	}
}
