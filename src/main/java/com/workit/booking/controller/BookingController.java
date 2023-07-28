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
import com.workit.common.Pagenation;

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
		m.addAttribute("pageBar",Pagenation.getPage(cPage,numPerpage,totalData,"bookingList.do"));
		m.addAttribute("totalData",totalData);
		m.addAttribute("list",list);
		return "booking/bookingList";
	}
	
	@GetMapping("/searchBooking.do")
	public String searchBooking(Model m, String type, String keyword,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
		List<Booking> list=service.searchBooking(Map.of("type",type,"keyword",keyword));
		int totalData=service.selectBookingCountByKeyword(Map.of("type",type,"numPerpage",numPerpage));
		m.addAttribute("pageBar",Pagenation.getPage(cPage,numPerpage,totalData,"searchBook.do"));
		m.addAttribute("totalData",totalData);
		m.addAttribute("list",list);
		return "booking/bookingList";
	}
	
	@GetMapping("/myBooking.do")
	public String myBooking(String userId,Model m) {
		//로그인된 사용자의 이름을 가져와서 예약자 이름에 매개변수로 넣어줘야
		String userName="";
		m.addAttribute("list",service.selectMyBooking(userName));
		m.addAttribute("title","나의 예약 내역");
		return "booking/bookingList";
	}
	@PostMapping("/addBooking.do")
	public String addNewBooking(Booking b, Model m) {
		
		return "booking/myBooking";
	}
	
	@GetMapping("/bookingDetail.do")
	public String bookingDetail(int bookingNo) {
		
		return "booking/bookingDetail.do";
	}
	
	@PostMapping("/updateBooking.do")
	public String updateBooking(Booking b) {
		
		return "booking/bookingDetail.do";
	}
}
