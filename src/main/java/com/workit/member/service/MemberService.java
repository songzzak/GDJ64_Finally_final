package com.workit.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.ApprovMemberVO;

public interface MemberService {
	Member selectMemberByParam(Map<String,Object> param);

	UserDetails loadUserByUsername(String username) throws UsernameNotFoundException;

	int updateProfileImg(Map<String, Object> param);

	int insertApprovMember(Map<String, Object> param);

	ApprovMemberVO selectApprovMember(String memberId);

	int selectApprovCount();

	List<ApprovMemberVO> selectApprovAll(Map<String, Object> param);

	int updatePwd(Map<String, Object> param);
}
