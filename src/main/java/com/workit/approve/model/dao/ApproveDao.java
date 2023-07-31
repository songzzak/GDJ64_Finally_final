package com.workit.approve.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.workit.approve.model.dto.Approve;

public interface ApproveDao {
	public List<Approve> selectAllWaitingApprove(SqlSession session,String memberId);
}
