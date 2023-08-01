package com.workit.approve.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.workit.approve.model.dto.Approve;
import com.workit.approve.service.ApproveService;

@Controller
@RequestMapping("/approve")
public class ApproveController {
	@Autowired
	private ApproveService service;
	
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
	
	/*
	 * @RequestMapping("/waitingApprove.do") public String
	 * selectWaitingApprove(Model m,@RequestParam(value="memberId") String memberId)
	 * { List<Approve> apps = service.selectAllWaitingApprove(memberId);
	 * m.addAttribute("apps", apps); return "approve/waiting-approve"; }
	 */
	
	@RequestMapping("/waitingApprove.do")
	public String selectWaitingApprove(Model m,@RequestParam(value="mId") String mId) {
		List<Approve> apps = service.selectAllWaitingApprove(mId);
		for(Approve app : apps) {
			System.out.println(app);
		}
		m.addAttribute("apps", apps);
		return "approve/expenditure-app";
	}
}
