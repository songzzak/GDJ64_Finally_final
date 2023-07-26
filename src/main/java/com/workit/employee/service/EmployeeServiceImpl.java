package com.workit.employee.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.workit.employee.dao.EmployeeDao;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;
@Service
public class EmployeeServiceImpl implements EmployeeService {
	private EmployeeDao dao;
	public EmployeeServiceImpl(EmployeeDao dao) {
		this.dao=dao;
	}
	@Override
	public List<Department> selectDept() {
		return dao.selectDept();
	}

	@Override
	public List<Job> selectJob() {
		return dao.selectJob();
	}

}
