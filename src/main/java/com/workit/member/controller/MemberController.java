package com.workit.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	
	@RequestMapping("/firstlogin")
	public String test() {
		return "member/mypage";
	}
}
