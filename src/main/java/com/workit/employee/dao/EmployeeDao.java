package com.workit.employee.dao;

import java.util.List;
import java.util.Map;

import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;
import com.workit.member.model.dto.Member;

public interface EmployeeDao {
	
	List<Department> selectDept();
	
	List<Job> selectJob();
	
	int insertEmployee(Map<String,Object> param);
	
	List<Member> selectMemberAll();
}
