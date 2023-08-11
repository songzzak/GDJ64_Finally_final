package com.workit.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.workit.member.model.dao.MemberDao;
import com.workit.member.model.vo.ApprovMemberVO;
import com.workit.member.model.vo.MemberVO;
@Service
public class MemberServiceImpl implements MemberService, UserDetailsService {
	@Autowired
	private MemberDao dao;
	@Autowired
	private BCryptPasswordEncoder encoder;
	
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
	public int updateMember(Map<String, Object> param) {
		if(param.get("password")!=null) {
			param.put("password", encoder.encode(dao.selectMemberByParam(param).getPassword())); //기존 비밀번호 암호화			
		}
		param.put("newPwd", encoder.encode((String)param.get("newPwd"))); //신규 비밀번호 암호화
		if(dao.selectMemberByParam(param)!=null) {
			return dao.updateMember(param);			
		}else {
			return -1;
		}
	}

	@Override
	public MemberVO selectMemberById(String memberId) {
		return dao.selectMemberById(memberId);
	}
	
	

}
