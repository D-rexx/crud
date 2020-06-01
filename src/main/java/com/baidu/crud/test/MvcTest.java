package com.baidu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.baidu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

/*
 * 使用spring测试模块的提供的模拟测试请求
 * 测试crud的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispantherServlet.xml" })
public class MvcTest {
	// 传入Springmvc的ioc需要借助@WebAppConfiguration注解进行自动装配
	@Autowired
	WebApplicationContext context;
	// 虚拟mvc请求,获取处理结果
	MockMvc mockMvc;

	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		System.out.println(mockMvc+"初始化模拟请求结束");
	}

	@Test
	public void testPage() throws Exception {
//		System.out.println("开始走走走走卒走走做足走走做祖宗做足走走走");
		// 模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

		System.out.println("result===" + result);
//System.out.println(result==null);
		// System.out.println("开始走走走走卒走走做足走走做祖宗做足走走走");
		// 请求成功后请求域中的pageInfo,我们取出pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		System.out.println("request====" + request);
//		System.out.println("开始走走走走卒走走做足走走做祖宗做足走走走");
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		request.getAttribute("pageInfo");
		System.out.println(pi);
		System.out.println("开始走走走走卒走走做足走走做祖宗做足走走走");
		System.out.println("当前页码" + pi.getPageNum());
		System.out.println("总页码" + pi.getPages());
		System.out.println("总记录数" + pi.getTotal());
		System.out.println("++++++++++++需要连续显示的页码+++++++++++++++");
		int[] nums = pi.getNavigatepageNums();
		for (int i = 0; i < nums.length; i++) {
			System.out.println(" " + i);
		}
		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println("ID" + employee.getEmpId() + "==>Name:" + employee.getEmpName());
		}

	}
}
