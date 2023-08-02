package com.workit.member.model.dao;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.member.mapper.MemberMapper;
import com.workit.member.model.dto.Member;
@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private MemberMapper mapper;

	@Override
	public Member selectMemberByParam(Map<String, Object> param) {
		return mapper.selectMemberByParam(param);
	}

	@Override
	public int updateProfileImg(Map<String, Object> param) {
		return mapper.updateProfileImg(param);
	}

}
