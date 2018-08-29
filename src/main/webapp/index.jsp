<%--
  Created by IntelliJ IDEA.
  User: GIGABYTE
  Date: 2018/8/17
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%--web路径问题：
    不以/开始的是相对路径，以来到当前页面的浏览器的路径为标准。不要用
    以/开始的路径，以服务器的根路径为标准的。即http://localhost:3306。注意不带项目名
    所以以/开始的路径，最开始要加项目名。如/ssmCRUD/XXXXX
    又因为项目名不能写死，所以要从request域中读取ContextPath，写路径的时候用EL表达式读取真实项目名
    --%>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
        //获取项目名，由此的到的路径以/开头，不以/结束
    %>
    <%--引入JQurey 必须放最前面--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery_1.12.4_jquery.min.js"></script>
    <%--引入bs样式 需要修改href--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <%--引入js文件--%>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>

<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <%--表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">
                                <%--每个部门的下拉项不能写死 要先查部门数据库然后再自动生成--%>
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

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <%--表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <%--显示错误信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                                <%--每个部门的下拉项不能写死 要先查部门数据库然后再自动生成--%>
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

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all" autocomplete="off"/>
                    </th>
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
    <%--分页数据--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area">
            <nav aria-label="Page navigation">
                <ul class="pagination">

                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>

<script type="text/javascript">

    var totalRecord;//总记录数 向跳转到最后一页 就跳转到一个很大的页数（总记录数） 插件自动到最后一页
    var currentPage;//保存当前页 在修改记录完后跳转到当前页
    //页面加载完成后 直接发送ajax请求 要到分页数据
    $(function () {
//      去首页
        to_page(1);
    });

    //    抽取出来的通用方法：跳转到哪一页
    function to_page(pn) {
        $.ajax({
//          这些是ajax请求需要的参数
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            //请求成功之后的回调函数
            success: function (result) {
                //成功获取到json数据之后要解析json
//              1解析并显示员工数据
                build_emps_tatle(result);
//              2解析并显示分页信息
                build_page_info(result);
                //  3解析显示分页条
                build_page_nav(result);
            }
        });
    }

    //              1解析并显示员工数据
    function build_emps_tatle(result) {
//      在任何构建之前 都要清空原有数据
        $("#emps_table tbody").empty()

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBox = $("<td><input type ='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            //处理性别显示
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加自定义的属性 表示当前员工的id
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append能链式操作的原因是append方法返回的还是原来的元素
            $("<tr></tr>").append(checkBox).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd)
                .append(deptNameTd).append(btnTd)
            //用选择器确定将这个tr插入到哪个地方
                .appendTo("#emps_table tbody");
        });
    }

    //              2解析并显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,共"
            + result.extend.pageInfo.pages + "页,共" + result.extend.pageInfo.total + "条记录。");
        currentPage = result.extend.pageInfo.pageNum;
        totalRecord = result.extend.pageInfo.total;
    }

    //  3解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();

//      构建元素
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
//          不要给disabled的元素绑定事件，不然事件也会执行
//          为元素添加单击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        } else {
//          不要给disabled的元素绑定事件，不然事件也会执行
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
//          绑定单击事件，能够跳转
            numLi.click(function () {
                to_page(item)
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");

    }

    //将弹出模态框事件绑定到添加按钮
    //先用选择器选到按钮 再调用模态框的modal方法
    $("#emp_add_modal_btn").click(function () {
//      首先要清空表单和已经存在的样式 防止自动保存上一次的信息 跳过发送ajax请求的用户名重复校验
        reset_form("#empAddModal form");
        //先发送ajax请求 获得部门信息 显示再下拉列表
        getDepts("#dept_add_select");
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    function reset_form(ele) {
//      重置表单内容
        $(ele)[0].reset();
//      清空表单样式
        //清空表单中所有原色的class的样式
        $(ele).find("*").removeClass("has-error has-success");
        //清空表单里的所有的信息提示文字 即class为help-block的span元素的text
        $(ele).find(".help-block").text("");

    }

    //查出所有的部门信息 并显示在下拉列表
    function getDepts(ele) {
        //清空原有信息
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result);
                //显示部门信息在下拉列表中
                $.each(result.extend.depts, function () {
//                  this表示当前正在遍历的元素
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    //  定义校验方法
    function validate_add_form() {
//      拿到要校验的数据 用正则校验
        //校验用户名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
//          如果失败
            //alert("用户名可以是2-5位中文或6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        //校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //  抽取出来显示校验结果的信息
    function show_validate_msg(ele, status, msg) {
//      不管成功失败都要清楚之前的校验状态 移除多个类用空格表示
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            //为了清空span元素里的错误信息
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            //校验失败的提示信息
            $(ele).parent().addClass("has-error");
            //找到input下的span元素 在里面显示错误信息
            $(ele).next("span").text(msg);
        }
    }


    //  发ajax校验用户名是否重复和是否满足格式要求 重复则不添加
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
//                  设置保存按钮的属性 使其在校验成功时可以点击 在校验不成功时不能点击
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    //设置保存按钮的属性 使其在校验成功时可以点击 在校验不成功时不能点击
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        })
    });

    //  绑定保存按钮的点击事件
    $("#emp_save_btn").click(function () {
//        判断ajax用户名重复校验是否成功
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
//      1先对要发给服务器的数据进行校验 前端校验
        if (validate_add_form() == false) {
            return false;
        }
//      2将模态框中填写的信息提交给服务器
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            //将这个表格的数据序列化，当作post的参数
            data: $("#empAddModal form").serialize(),
            success: function (result) {
//              根据后端校验结果 进行处理
                if (result.code == 100) {
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    //来到最后一页 显示保存的数据
                    //可以设定跳到一个很大的页数，分页插件会自动的跳到最后一页
                    to_page(totalRecord);
                } else {
                    //有哪个字段的错误信息 就显示哪个字段
                    if (result.extend.errorFields.email != undefined) {
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email)
                    }
                    if (result.extend.errorFields.empName != undefined) {
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName)
                    }
                }
            }
        })
    });

    //编辑按钮是在执行ajax之后才生成的，直接绑定单击事吉安.click是不行的
    //要么在生成按钮的js代码中绑定事件，要么使用jquery的on方法，为后来生成的元素绑定事件
    //on方法的调用主体要是父元素（一般为document元素），而on方法的第二个参数才是真正要绑定的元素的选择器，详见jq文档
    $(document).on("click", ".edit_btn", function () {
        //1.查出部门信息 并显示部门列表
        getDepts("#empUpdateModal select");
        //2.查出员工信息 必须在查部门后面
        getEmp($(this).attr("edit-id"));
        //把员工的id传递给更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        //3.弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    //查询员工信息并显示
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);//单选框选中 传入数组
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    /*
* 坑！！！
* 两个表连接查询的结果，mysql的默认排序是先按部门类型分成几组，每组分别按id排序
* 这会造成修改了一条记录的部门后，该记录跑到很多页之后。每个部门扎堆显示，导致顺序混乱
* 比如前500条是开发部 后500条是测试部 修改第一条为测试部 第一条就跑到第500个的位置上
* 即第一条记录从第一页 跑到 第n页
* 必须传入order by emp_id
* */
    //更新按钮绑定单击事件
    $("#emp_update_btn").click(function () {
        //先检查邮件是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求 保存修改
        //ajax支持直接发送put请求，但是直接发送put
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                console.log(result)
                //关闭模态框
                $("#empUpdateModal").modal("hide");
                //回到这个记录所在的页面
                to_page(currentPage);
            }

        });
    });

//  删除单个员工
    $(document).on("click", ".delete_btn", function () {
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        //跳出提示框
        if(confirm("确定要删除"+empName+"吗？")){
            var empId=$(this).attr("del-id");
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
    //全选全不选的checkbox
    $("#check_all").click(function () {
        //用attr获取checked属性值是undefined的，不应该用attr
        //应该用prop改变或读取dom原生元素的属性值
        //用attr获取自定义属性的值，或者增加自定义属性
        //alert($(this).prop("checked"));
//      将关联的选择框的checked属性设e置成总的选择框的checked属性，来实现全选全不选的功能
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //为每一个check_item绑定点击事件，当所有check_item被选上了，check_all也要被选上
    //check_item是动态生成的 要用on绑定事件
    $(document).on("click",".check_item",function () {
        //判断是不是所有check_item都被选上了
        var flag= $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除 就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames="";
        var del_idstr="";
        //遍历每一个被选中的框 this表示当前的
        $.each($(".check_item:checked"),function () {
           empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
           del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //取出结尾多余的逗号和-
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除"+empNames+"吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    });
</script>
