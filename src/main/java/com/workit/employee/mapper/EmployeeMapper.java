package com.workit.employee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;

@Mapper
public interface EmployeeMapper {
	@Select("SELECT * FROM DEPARTMENT_TB")
	List<Department> selectDept();
	
	@Select("SELECT * FROM JOB_TB")
	List<Job> selectJob();
}
