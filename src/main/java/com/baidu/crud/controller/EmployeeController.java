package com.baidu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.crud.bean.Employee;
import com.baidu.crud.bean.Msg;
import com.baidu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/*
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;

	// 员工单个删除方法
	// 员工批量删除方法二合一
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids") String ids) {
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBacth(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();

	}

	// 更新并保存员工信息
	// 占位符{empId}与实例中的属性名要一致
	/*
	 * 关于封装的问题 原因:Tomcat: 将请求体重的数据封装一个map request.getParameter("empName")就会重map中取值
	 * SpringMvc封装POJO对象的时候 会把POJO中每个属性的值通过request.getParameter("empName")获得\
	 * AJAX发送PUT请求引发的血案 PUT请求,请求体重的数据 request.getParameter("empName")拿不到
	 * tomcat一看是put请求,就不会将请求数据封装为map,只有post请求才封装请求体为map
	 * 
	 * 
	 * 解决方案 直接配上HttpPutFormContentFilter过滤器 从来支持发送PUT之类的请求还要封装请求体中的数据
	 * request被重新包装,request.getParameter()被重写,就会 从自己封装的请求体重拿数据
	 */

	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		System.out.println("将要更新员工数据:++" + employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}

	// 根据员工Id查询员工信息
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName") String empName) {
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
		if (!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
		}
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}

	}

	// 员工数据保存
	// 规定请求方式
	@RequestMapping(value = "/emp_save", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("ErrorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}

	}

	// @ResponseBody 自动将响应内容转换为json字符串给页面

	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入PageHelper分页插件的jar包
		// 在查询之前传入页码以及每页数据大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用PageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
		// 封装了详细页面信息,包括有我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		// 把数据装进map里面返回给页面
		return Msg.success().add("pageInfo", page);
	}

	/*
	 * 员工分页查询
	 */
//	@RequestMapping("/emps")
	// @requestParam() 设置分页查询默认的页面信息 默认显示第一页信息
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入PageHelper分页插件的jar包
		// 在查询之前传入页码以及每页数据大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();

		// 使用PageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
		// 封装了详细页面信息,包括有我们查询出来的数据,传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);

		model.addAttribute("pageInfo", page);

		return "list4";
	}
}
