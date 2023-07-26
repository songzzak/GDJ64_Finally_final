package com.workit.employee.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.workit.employee.mapper.EmployeeMapper;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;
@Repository
public class EmployeeDaoImpl implements EmployeeDao {
	private EmployeeMapper mapper;
	public EmployeeDaoImpl(EmployeeMapper mapper) {
		this.mapper=mapper;
	}
	@Override
	public List<Department> selectDept() {
		return mapper.selectDept();
	}

	@Override
	public List<Job> selectJob() {
		return mapper.selectJob();
	}

}
