package com.workit.member.model.dao;

import java.util.Map;

import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.ApprovMemberVO;

public interface MemberDao {
	Member selectMemberByParam(Map<String,Object> param);

	int updateProfileImg(Map<String, Object> param);

	int insertApprovMember(Map<String, Object> param);

	ApprovMemberVO selectApprovMember(String memberId);
}
