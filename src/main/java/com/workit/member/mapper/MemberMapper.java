package com.workit.member.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.ApprovMemberVO;

@Mapper
public interface MemberMapper {
	
	Member selectMemberByParam(Map<String, Object> param);

	int updateProfileImg(Map<String, Object> param);

	int insertApprovMember(Map<String, Object> param);

	ApprovMemberVO selectApprovMember(String memberId);
}
