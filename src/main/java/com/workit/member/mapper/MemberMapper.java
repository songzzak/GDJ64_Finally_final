package com.workit.member.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.workit.member.model.dto.Member;

@Mapper
public interface MemberMapper {
	
	Member selectMemberByParam(Map<String, Object> param);

	int updateProfileImg(Map<String, Object> param);
}
