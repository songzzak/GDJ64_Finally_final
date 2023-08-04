package com.workit.booking.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.workit.booking.dao.BookingDao;
import com.workit.booking.model.dto.Booking;
import com.workit.booking.model.dto.Facility;

@Service
public class BookingServiceImpl implements BookingService {

	private BookingDao dao;
	private SqlSession session;
	
	public BookingServiceImpl(BookingDao dao, SqlSession session) {
		this.dao=dao;
		this.session=session;
	}

	@Override
	public List<Booking> selectAllBooking(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.selectAllBooking(session,param);
	}
	@Override
	public int selectBookingCount() {
		// TODO Auto-generated method stub
		return dao.selectBookingCount(session);
	}
	@Override
	public List<Booking> searchBooking(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.searchBooking(session,param);
	}
	@Override
	public int selectBookingCountByKeyword(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return dao.selectBookingCountByKeyword(session,param);
	}

	@Override
	public List<Booking> selectMyBooking(String userName) {
		// TODO Auto-generated method stub
		return dao.selectMyBooking(session,userName);
	}

	@Override
	public List<Facility> selectAllFacilities() {
		// TODO Auto-generated method stub
		return dao.selectAllFacilities(session);
	}
}
