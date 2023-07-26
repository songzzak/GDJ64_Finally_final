package com.workit.employee.dao;

import java.util.List;

import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;

public interface EmployeeDao {
	List<Department> selectDept();
	
	List<Job> selectJob();
}
