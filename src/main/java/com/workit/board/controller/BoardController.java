package com.workit.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.workit.board.model.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	private BoardService service;
	
	@Autowired
	public BoardController(BoardService service) {
		this.service = service;
	}
	
	@GetMapping("/noticeList")
	public String noticeList() {
		return "board/noticeList";
	}
			

}
