<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
	不以/开始的相对路径，以当前资源的路径为基准，容易出现问题
	以/开始的相对路径，资源以服务器的路径为标准
	比如(http://localhost:3360):需要加上项目名
	http://localhost:3306/crud
 -->
<!-- Bootstrap -->
<link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${APP_PATH}/static/js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- js插件模态框 -->
	<!-- 员工编辑模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
								<span class="help-block"></span>

							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@qq.com"> <span
									class="help-block"></span>

							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工部门</label>
							<div class="col-sm-5">
								<select class="form-control" name="dId" id="dept_update_select">
									<!-- 部门提交id -->
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 添加员工的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@qq.com"> <span
									class="help-block"></span>

							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工部门</label>
							<div class="col-sm-5">
								<select class="form-control" name="dId" id="dept_add_select">
									<!-- 部门提交id -->
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>员工信息管理系统</h1>
			</div>
		</div>
		<!-- 新增 删除 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button id="emp_add_modal_btn" type="button" class="btn btn-primary">新增</button>
				<button id="emp_delete_all" type="button" class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-striped" id="emps_table">
					<thead>
						<tr>
							<th>
							<input type="checkbox"  id="check_all"/>
							</th>
							<th>ID</th>
							<th>empname</th>
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
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		//设置全局变量方便访问
		var totalRecord,currentPage;

		$(function() {
			to_page(1)
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "get",
				//响应成功后的回调函数
				success : function(result) {
					//console.log(result);
					//解析并显示员工数据
					build_emps_table(result);
					//解析并显示分页信息
					build_page_info(result);
					//显示分页条
					build_page_nav(result);
				}
			});
		}

		function build_emps_table(result) {
			//获取数据前先清空数据
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加自定义属性来表示员工ID方便 请求方法的 取值
				editBtn.attr("edit-id",item.empId);
				
				
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-remove")).append("删除");
				//为删除按钮添加自定义属性来表示员工ID方便ajax请求方法取值
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn)
				.append(" ")
				.append(
						delBtn)
				$("<tr></tr>").append(checkBoxTd)
							  .append(empIdTd)
							  .append(empNameTd)
							  .append(genderTd)
							  .append(emailTd)
							  .append(deptNameTd)
						      .append(btnTd)
							  .appendTo("#emps_table tbody");
			});
		}
		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第-" + result.extend.pageInfo.pageNum + "-页," + "总-"
							+ result.extend.pageInfo.pages + "-页," + "共有-"
							+ result.extend.pageInfo.total + "-条记录");
			//给全局变量赋值
			totalRecord = result.extend.pageInfo.pages;
			currentPage=result.extend.pageInfo.pageNum;

		}
		//解析显示分页条
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var pretPageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				pretPageLi.addClass("disabled");
			} else {
				//为元素添加点击事件
				firstPageLi.click(function() {
					to_page(1);
				});
				pretPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1)
				});
			}

			var nextpageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lasttPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextpageLi.addClass("disabled");
				lasttPageLi.addClass("disabled");
			} else {
				nextpageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1)
				});

				lasttPageLi.click(function() {
					to_page(result.extend.pageInfo.pages)
				});
			}

			ul.append(firstPageLi).append(pretPageLi);

			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				})
				ul.append(numLi)
			});
			ul.append(nextpageLi).append(lasttPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		//模态框绑定事件
		$("#emp_add_modal_btn").click(function() {
			//重置表单数据\
			//DOM对象的reset()方法
			//$("#empAddModal form")[0].reset();
			reset_form("#empAddModal form");
			//发送ajax请求,查出部门信息显示在下拉列表
			getDepts("#empAddModal select");
			$("#empAddModal").modal({
				backrop : "static"
			});
		});

		//查所有部门名称
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "get",
				success : function(result) {
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}

		//重置表单方法
		function reset_form(ele) {
			$(ele)[0].reset();
			//清空样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		};

		//校验表单数据方法
		function validate_add_form() {
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if (!regName.test(empName)) {
				show_validate_msg("#empName_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字的组合");
				/* $("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				 */
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
				/* $("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text();
				 */
			}
			;
			//邮箱验证
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");

				/* 	$("#email_add_input").parent().addClass("has-error");
					$("#email_add_input").next("span").text("邮箱格式不正确");
				 */
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
				/* 	$("#email_add_input").parent().addClass("has-success");
					$("#email_add_input").next("span").text(); */

			}
			;
			return true;
		}

		//抽取正则验证代码块
		function show_validate_msg(ele, status, msg) {
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);

			} else if ("error" == status)
				$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);

		}

		//给员工新增绑定事件来判断是否存在姓名已存在
		$("#empName_add_input").change(
				function() {
					//发送ajax请求检验用户名是否存在
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						type : "POST",
						data : "empName=" + empName,
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#empName_add_input",
										"success", "用户名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}

						}

					});
				});

		//保存员工数据
		//emp_save_btn
		$("#emp_save_btn")
				.click(
						function() {
							//提交给服务器的数据进行校验
							/* 	if (!validate_add_form()) {
									return false;
							}; */

							if ($(this).attr("ajax-va") == "error") {
								return false;
							}

							$
									.ajax({
										url : "${APP_PATH}/emp_save",
										type : "POST",
										data : $("#empAddModal form")
												.serialize(),
										success : function(result) {
											if (result.code == 100) {
												//关闭模态框
												$("#empAddModal").modal('hide');
												//显示保存的数据
												to_page(totalRecord);
											} else {
												//显示失败信息
												if (undefined != result.extend.errorField.email) {
													show_validate_msg(
															"#email_add_input",
															"error",
															result.extend.errorField.email);
												}
												if (undefined != result.extend.errorField.empName) {
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errorField.empName);

												}
											}
										}
									});
						});

		//给编辑按钮绑定click.因为绑定事件发生在按钮创建之前,所以帮不上
		//需要使用jq中的.live()方法,在新版中此方法被删除
		//可以使用on进行绑定选着父类元素.on(事件,"点"需要绑定的子元素)
		$(document).on("click", ".edit_btn", function() {
			//alert("edit_btn");
			getEmp($(this).attr("edit-id"));
			getDepts("#empUpdateModal select");
			//把员工Id传递给更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				backrop : "static"
			});

		});
		//给删除按钮绑定点击事件
		$(document).on("click",".delete_btn",function(){
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(2)").text());
			//弹出是否删除对话框
			if (confirm("确认删除【"+empName+"】吗?")) {
				//点击确认后发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本业
						to_page(currentPage);
					}
					
				});
			}
		});

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					//console.log(result);
					var empData =result.extend.emp;
					
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		
		//更新员工按钮绑定事件
		//因为员工名不可更改,所以只需要验证邮箱
		$("#emp_update_btn").click(function(){
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
						
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确000");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			//发送请求保存信息
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"POST",
				//需要添加method=PUT,控制成的响应方法是PUT而ajax发送的是POST请求
				data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				
				success : function(result) {
					//alert(result.msg);
					//关闭模态框
					$("#empUpdateModal").modal("hide");
					//重新请求当前页面
					to_page(currentPage);
				}
			});
		});
		//完成全选全不选
		$("#check_all").click(function(){
			//attr获得checked是undefined
			//原生DOM属性使用prop获取属性,自定义属性用attr获取
			//使用prop读取和改变DOM原生的值
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"))
		});
		
		$(document).on("click",".check_item",function(){
			//判断当前选中的元素是否有5个
			//alert($(".check_item:checked").length);
		var flag=$(".check_item:checked").length==$(".check_item").length;
				$("#check_all").prop("checked",flag);
		});
		//给删除按钮绑定点击事件
		$("#emp_delete_all").click(function(){
			//$(".check_item:checked")
			var empNames="";
			var del_idstr = "";
		
			$.each($(".check_item:checked"),function(){
			empNames +=	"-"+$(this).parents("tr").find("td:eq(2)").text()+"-";
			del_idstr +=    $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
		//	empNames=empNames.substring(0,empNames.length-1);
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
		if (confirm("确认删除【"+empNames+"】吗?")) {
			//alert(del_idstr);
			$.ajax({
				url:"${APP_PATH}/emp/" + del_idstr,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					to_page(currentPage);
				}
					
				}); 
			}
		});
	</script>
	
	

</body>
</html>