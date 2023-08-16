package com.workit.booking.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.workit.booking.model.dto.Booking;
import com.workit.booking.model.dto.Facility;

@Repository
public class BookingDaoImpl implements BookingDao {

	@Override
	public List<Booking> selectAllBooking(SqlSession session, Map<String,Object> param) {
		//페이징처리
		int cPage=(int)param.get("cPage");
		int numPerpage=(int)param.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("booking.selectAllBooking",null,rb);
	}

	@Override
	public List<Booking> searchBooking(SqlSession session, Map<String, Object> param) {
		int cPage=(int)param.get("cPage");
		int numPerpage=(int)param.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("booking.selectBookingByKeyword",param,rb);
	}

	@Override
	public int selectBookingCount(SqlSession session) {
		
		return session.selectOne("booking.selectBookingCount");
	}

	@Override
	public int selectBookingCountByKeyword(SqlSession session, Map<String, Object> param) {
		
		return session.selectOne("booking.selectBookingCountByKeyword",param);
	}

	@Override
	public List<Booking> selectMyBooking(SqlSession session, String userName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Facility> selectAllFacilities(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("booking.selectAllFacilities");
	}

}
