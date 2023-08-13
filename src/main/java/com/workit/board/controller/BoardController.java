package com.workit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.workit.board.model.dto.Notice;
import com.workit.board.model.service.BoardService;
import com.workit.common.Pagenation;
import com.workit.member.model.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	private BoardService service;
	
	@Autowired
	public BoardController(BoardService service) {
		this.service = service;
	}
	
	@GetMapping("/noticeList")
	public String noticeList(Model model, @RequestParam(value="cPage",defaultValue="1") int cPage) {
		List<Notice> noticeList = service.selectNoticeAll(Map.of("cPage",cPage,"numPerpage",10));
		 int totalData=service.selectNoticeCount();
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageBar",Pagenation.getPage(cPage,10,totalData,"/board/noticeList"));
		return "board/noticeList";
	}
	@GetMapping("/noticeView")
	public String noticeView(Model model, @RequestParam int no) {
		model.addAttribute("n", service.selectNoticeByNo(no));
		model.addAttribute("commentList", service.selectCommentList(no));
		model.addAttribute("prevNotice", service.selectNoticeByNo(no-1));
		model.addAttribute("nextNotice", service.selectNoticeByNo(no+1));
		return "board/noticeView";
	}
	
	@PostMapping("/noticeCommentAdd")
	@ResponseBody
	public String addNoticeComment(@RequestParam int noticeNo, @RequestParam String commentContent,
            @RequestParam(required = false) Integer refCommentNo, HttpSession session) {
		 Map<String, Object> map = new HashMap<>();
		String memberId=((MemberVO)session.getAttribute("loginMember")).getMemberId();
		map.put("memberId", memberId);
		map.put("noticeNo", noticeNo);
		map.put("commentContent", commentContent);
		map.put("refCommentNo", refCommentNo);
		//System.out.println(map);
	    service.insertNoticeComment(map);

	    return "success";
	}
	
	@PostMapping("/noticeCommentDelete")
	public void noticeCommentDelete(@RequestParam int commentNo, HttpServletResponse response) throws IOException {
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	        service.deleteNoticeComment(commentNo);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	
	}
	
	@PostMapping("/noticeCommentUpdate")
	public void noticeCommentUpdate(@RequestParam int commentNo, @RequestParam String commentContent,
		 HttpServletResponse response) throws IOException {
		 Map<String, Object> map = new HashMap<>();
		map.put("commentNo", commentNo);
		map.put("commentContent", commentContent);
	    
	    Map<String, String> resultMap = new HashMap<>();
	    try {
	    	service.updateNoticeComment(map);
	        resultMap.put("status", "success");
	    } catch (Exception e) {
	        resultMap.put("status", "error");
	    }
	    Gson gson = new Gson();
	    String json = gson.toJson(resultMap);
	    response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
	}
	

}
