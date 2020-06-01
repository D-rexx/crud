package com.baidu.crud.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.annotations.CacheNamespaceRef;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.baidu.crud.bean.Department;
import com.baidu.crud.bean.Employee;
import com.baidu.crud.dao.DepartmentMapper;
import com.baidu.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)

@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestCRUD {

	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;


	@Test

	public void testmaper() {
		
		
		/*
		 * List<Department> ll=departmentMapper.selectByExample(null); for (Department
		 * department : ll) { System.out.println(department.getDeptName()); }
		 */
		
		List<Employee> l = employeeMapper.selectByExampleWithDept(null);
		for (Employee employee : l) {
			System.out.println(employee.getDepartment().getDeptName());
		}
		
		System.out.println(l.size());
	}
}
