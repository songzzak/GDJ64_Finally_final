package com.workit.booking.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.workit.booking.model.dto.Booking;
import com.workit.booking.service.BookingService;

@Controller
@RequestMapping("/booking")
public class BookingController {
	
	private BookingService service;
	
	public BookingController(BookingService service) {
		this.service=service;
	}
	
	@GetMapping("/bookingList.do")
	public String selectAllBooking(Model m, @RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage){
		List<Booking> list=service.selectAllBooking(Map.of("cPage",cPage,"numPerpage",numPerpage));
		int totalData=service.selectBookingCount();
		m.addAttribute("pageBar",PageFactory.getPage(cPage,numPerpage,totalData,"bookingList.do"));
		m.addAttribute("totalData",totalData);
		m.addAttribute("list",list);
		return "";
	}
	
	@GetMapping("/searchBooking.do")
	public String searchBooking(Model m, String type, String keyword,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
		List<Booking> list=service.searchBooking(Map.of("type",type,"keyword",keyword));
		int totalData=service.selectBookingCountByKeyword(Map.of("type",type,"numPerpage",numPerpage));
		m.addAttribute("pageBar",PageFactory.getPage(cPage,numPerpage,totalData,"searchBook.do"));
		m.addAttribute("totalData",totalData);
		m.addAttribute("list",list);
		return "";
	}
	
	@PostMapping("/addBooking.do")
	public String addNewBooking(Booking b) {
		
		return "";
	}
	
	@GetMapping("/bookingDetail.do")
	public String bookingDetail(int bookingNo) {
		
		return "";
	}
	
	@PostMapping("updateBooking.do")
	public String updateBooking(Booking b) {
		
		return "";
	}
}
