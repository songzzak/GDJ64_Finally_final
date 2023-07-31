package com.workit.approve.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.workit.approve.model.dto.Approve;

@Repository
public class ApproveDaoImpl implements ApproveDao {

	@Override
	public List<Approve> selectAllWaitingApprove(SqlSession session, String memberId) {
		return session.selectList("approve.selectAllWaitingApprove",memberId);
	}

}
