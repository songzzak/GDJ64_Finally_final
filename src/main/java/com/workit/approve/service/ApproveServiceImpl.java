package com.workit.approve.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.workit.approve.model.dao.ApproveDao;
import com.workit.approve.model.dto.Approve;

@Service
public class ApproveServiceImpl implements ApproveService {

	@Autowired
	private ApproveDao dao;
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Approve> selectAllWaitingApprove(String mId) {
		
		return dao.selectAllWaitingApprove(session,mId);
	}

}
