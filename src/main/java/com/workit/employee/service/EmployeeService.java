package com.workit.employee.service;

import java.util.List;

import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;

public interface EmployeeService {
	List<Department> selectDept();
	
	List<Job> selectJob();
}
