package com.workit.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	
	@PostMapping("/member/profile")
	public String updateProfile(MultipartFile profileImg, HttpSession session, Model model) {
		String path = session.getServletContext().getRealPath("/resources/upload/profile/"); //파일 저장 경로
		if (!profileImg.getOriginalFilename().equals("")) { //파일이 있으면 실행
			String oriName=profileImg.getOriginalFilename();
			Date today = new Date(System.currentTimeMillis());
			String ext=oriName.substring(oriName.lastIndexOf("."));
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			int random = (int) (Math.random() * 10000) + 1;
			String rename = sdf.format(today) + "_" + random+ext;
			try {
				profileImg.transferTo(new File(path + rename));
			} catch (IOException e) {
				e.printStackTrace();
			}
			Map<String,Object> param=new HashMap<>();
			param.put("profileImg", rename);
			param.put("memberId", ((Member)session.getAttribute("loginMember")).getMemberId());
			if(service.updateProfileImg(param)>0) {
				model.addAttribute("msg","프로필 수정되었습니다.");
				model.addAttribute("url","/mypage");
				session.setAttribute("loginMember", service.selectMemberByParam(param));
			}else {
				model.addAttribute("msg","프로필 수정 실패하였습니다.");
				model.addAttribute("url","/mypage");
			}
		}
		return "common/msg";
	}
}
