package com.workit.member.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	
	@RequestMapping("/login")
	public String loginpage() {
		return "member/login";
	}
	
//	@RequestMapping("/")
//	public String mainpage(@RequestParam Map<String,Object> param) {
//		
//		return "index";
//	}
	
	@GetMapping("/mypage")
	public String enrollView(Model model) {
		return "member/mypage";
	}
}
