package com.workit.booking.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.workit.booking.model.dto.Booking;

@Repository
public class BookingDaoImpl implements BookingDao {

	@Override
	public List<Booking> selectAllBooking(SqlSession session) {
		//페이징처리
		RowBounds rb=;
		return session.selectList("booking.selectAllBooking",null,rb);
	}

}
