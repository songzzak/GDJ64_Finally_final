package com.workit.booking.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.workit.booking.model.dto.Booking;
import com.workit.booking.model.dto.Facility;

public interface BookingDao {

	List<Booking> selectAllBooking(SqlSession session,Map<String,Object> param);

	List<Booking> searchBooking(SqlSession session, Map<String, Object> param);

	int selectBookingCount(SqlSession session);

	int selectBookingCountByKeyword(SqlSession session, Map<String, Object> param);

	List<Booking> selectMyBooking(SqlSession session, String userName);

	List<Facility> selectAllFacilities(SqlSession session);

}
