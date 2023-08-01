package com.workit.employee.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;
import com.workit.member.model.dto.Member;

@Mapper
public interface EmployeeMapper {
	List<Department> selectAllDept();
	 List<Member> selectMemberAllByJob();
    List<Department> selectDeptAll();

    List<Job> selectJobAll();

    int insertEmployee(Map<String, Object> param);

    List<Member> selectMemberAll();
}
