package com.baidu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.crud.bean.Department;
import com.baidu.crud.bean.Msg;
import com.baidu.crud.service.DepartmentService;

/*
 * 处理部门相关请求
 */
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> list=departmentService.getDepts();
		return Msg.success().add("depts", list);
	}

}
