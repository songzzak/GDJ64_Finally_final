package com.workit.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.workit.member.model.dao.MemberDao;
import com.workit.member.model.vo.ApprovMemberVO;
import com.workit.member.model.vo.MemberVO;
@Service
public class MemberServiceImpl implements MemberService, UserDetailsService {
	@Autowired
	private MemberDao dao;
	
	@Override
	public MemberVO selectMemberByParam(Map<String, Object> param) {
		return dao.selectMemberByParam(param);
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO loginMember=dao.selectMemberByParam(Map.of("memberId",username));
		if(loginMember==null) return null;
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

	@Override
	public int selectApprovCount() {
		return dao.selectApprovCount();
	}

	@Override
	public List<ApprovMemberVO> selectApprovAll(Map<String, Object> param) {
		return dao.selectApprovAll(param);
	}

	@Override
	public int updatePwd(Map<String, Object> param) {
		if(dao.selectMemberByParam(param)!=null) {
			return dao.updatePwd(param);			
		}else {
			return -1;
		}
	}

	@Override
	public MemberVO selectMemberById(String memberId) {
		return dao.selectMemberById(memberId);
	}
	
	

}
