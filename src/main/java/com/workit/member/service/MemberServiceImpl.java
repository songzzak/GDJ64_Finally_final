package com.workit.member.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.workit.member.model.dao.MemberDao;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.ApprovMemberVO;
@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao dao;
	
	@Override
	public Member selectMemberByParam(Map<String, Object> param) {
		return dao.selectMemberByParam(param);
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Member loginMember=dao.selectMemberByParam(Map.of("userId",username));
		return loginMember;
	}

	@Override
	public int updateProfileImg(Map<String, Object> param) {
		return dao.updateProfileImg(param);
	}

	@Override
	public int insertApprovMember(Map<String, Object> param) {
		return dao.insertApprovMember(param);
	}

	@Override
	public ApprovMemberVO selectApprovMember(String memberId) {
		return dao.selectApprovMember(memberId);
	}
	
	

}
