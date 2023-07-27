package com.workit.booking.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Booking {
	private int bookingNo;
	private Date bookingDate;
	private int startTime;
	private int endTime;
	private String memberId;
	private String memo;
	private String bookingCanceled;
	private int facNo;
	private int purpose;
}
