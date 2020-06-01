<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入标签库 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 -->
<title>员工列表</title>
<!-- 不以/开的的相对路径,将以当前资源的路径为基础,容易出问题 -->
<!-- 以/开始的路径,找资源以服务器路径为标准需要加上项目名
	http://localhost:3306/crud
 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css"
	rel="stlesheet">
<!-- 引入jquery -->
<script src="${APP_PATH}/static/js/jquery.min.js"></script>
<!-- 引入BootStrap样式 -->
<script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建页面 -->
	<div class="container">
		<!-- 显示标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>MMS-CRUD</h1>
			</div>
		</div>
		<!-- 显示按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>


		<!-- 显示表信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
				<thead>
			
				<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
				
				</thead>
				<tbody>
				
				
				</tbody>	
					
				</table>

			</div>
		</div>
		<!-- 显 分页信息-->
		<div class="row">
			<!-- 分页信息:当前共多少信息 -->
			<div class="col-mdd-6">
			当前页,总页,总条记录</div>
			<!-- 分页信息 -->
			<div class="col-mdd-6">
			</div>
		</div>
	</div>
	<!-- 页面加载完成以后直接发送一个ajax请求要到分页数据 -->
	<script type="text/javascript">
		$(function(){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=1",
				type:"get",
				success:function(result){
					// 控制台输出结果
					//console.log(result);
					build_emps_table(result);
				}
			});
			
		});
		function build_emps_table(result){
			var emps=result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptname);
				//apend方法执行 完成以后还是返回原来的元素
				$("<tr></tr>")	.append(empIdTd)
								.append(empNameTd)
								.append(genderTd)
								.append(emailTd)
								.append(deptNameTd)
								.apentTo("#emps_table tbody");
				
				
			});
		}
		
		
		function build_page_nav(result){}
	
	</script>

</body>
</html>