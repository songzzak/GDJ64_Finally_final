package com.workit.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.workit.member.model.dto.Member;
import com.workit.member.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService service;
	
	@RequestMapping("/login")
	public String loginpage() {
		return "member/login";
	}
	
	@RequestMapping("/")
	public String mainpage(@RequestParam Map<String,Object> param, HttpSession session) {
		//Object loginMember=SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Member loginMember=service.selectMemberByParam(param);
		session.setAttribute("loginMember", loginMember);
		return "index";
	}
	
	@GetMapping("/mypage")
	public String enrollView(Model model) {
		return "member/mypage";
	}
	
	@GetMapping("/login/password")
	public String loginPwdView() {
		return "member/passwordReissue";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "member/login";
	}
}
