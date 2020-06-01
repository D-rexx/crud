package com.baidu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baidu.crud.bean.Employee;
import com.baidu.crud.bean.EmployeeExample;
import com.baidu.crud.bean.EmployeeExample.Criteria;
import com.baidu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	
	//查員工
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	
/*
 * 校验用户名是否可用
 * true 代表当前姓名可用,false代表不可用
 * 
 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	// 保存员工数据到数据库方法
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}
	
	//员工更新方法
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	//单个员工删除方法
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	//批量删除方法
	public void deleteBacth(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

	

	

	

}
