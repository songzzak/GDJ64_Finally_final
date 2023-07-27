package com.workit.booking.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.workit.booking.model.dto.Booking;

public interface BookingDao {

	List<Booking> selectAllBooking(SqlSession session);

}
