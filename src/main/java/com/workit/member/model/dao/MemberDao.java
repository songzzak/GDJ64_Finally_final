package com.workit.member.model.dao;

import java.util.Map;

import com.workit.member.model.dto.Member;

public interface MemberDao {
	Member selectMemberByParam(Map<String,Object> param);
}
