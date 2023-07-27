package com.workit.booking.service;

import java.util.List;

import com.workit.booking.model.dto.Booking;

public interface BookingService {

	List<Booking> selectAllBooking();

}
