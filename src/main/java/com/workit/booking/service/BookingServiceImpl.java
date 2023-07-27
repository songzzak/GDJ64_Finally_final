package com.workit.booking.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.workit.booking.dao.BookingDao;
import com.workit.booking.model.dto.Booking;

@Service
public class BookingServiceImpl implements BookingService {

	private BookingDao dao;
	private SqlSession session;
	
	public BookingServiceImpl(BookingDao dao, SqlSession session) {
		this.dao=dao;
		this.session=session;
	}
	@Override
	public List<Booking> selectAllBooking(){
		return dao.selectAllBooking(session);
	}
}
