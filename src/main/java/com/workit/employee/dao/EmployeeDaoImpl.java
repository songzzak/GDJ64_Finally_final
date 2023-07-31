package com.workit.employee.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.employee.mapper.EmployeeMapper;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;
import com.workit.member.model.dto.Member;
@Repository
public class EmployeeDaoImpl implements EmployeeDao {
	@Autowired
	private EmployeeMapper mapper;
	
	@Override
	public List<Department> selectDept() {
		return mapper.selectDeptAll();
	}

	@Override
	public List<Job> selectJob() {
		return mapper.selectJobAll();
	}

	@Override
	public int insertEmployee(Map<String, Object> param) {
		return mapper.insertEmployee(param);
	}

	@Override
	public List<Member> selectMemberAll() {
		return mapper.selectMemberAll();
	}

}
