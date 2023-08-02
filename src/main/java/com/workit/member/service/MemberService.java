package com.workit.member.service;

import java.util.Map;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.workit.member.model.dto.Member;

public interface MemberService {
	Member selectMemberByParam(Map<String,Object> param);

	UserDetails loadUserByUsername(String username) throws UsernameNotFoundException;
}
