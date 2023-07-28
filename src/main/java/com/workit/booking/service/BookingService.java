package com.workit.booking.service;

import java.util.List;
import java.util.Map;

import com.workit.booking.model.dto.Booking;

public interface BookingService {

	List<Booking> selectAllBooking(Map<String,Object> param);

	int selectBookingCount();

	List<Booking> searchBooking(Map<String, Object> param);

	int selectBookingCountByKeyword(Map<String, Object> param);

	List<Booking> selectMyBooking(String userName);

}
