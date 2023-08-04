package com.workit.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.member.mapper.MemberMapper;
import com.workit.member.model.dto.Member;
import com.workit.member.model.vo.ApprovMemberVO;
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

	@Override
	public int insertApprovMember(Map<String, Object> param) {
		return mapper.insertApprovMember(param);
	}

	@Override
	public ApprovMemberVO selectApprovMember(String memberId) {
		return mapper.selectApprovMember(memberId);
	}

	@Override
	public int selectApprovCount() {
		return mapper.selectApprovCount();
	}

	@Override
	public List<ApprovMemberVO> selectApprovAll(Map<String, Object> param) {
		int cPage=(int)param.get("cPage");
		int numPerpage=(int)param.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return mapper.selectApprovAll(rb);
	}
	
}
