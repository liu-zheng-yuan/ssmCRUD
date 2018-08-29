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
         pageContext.setAttribute("APP_PATH",request.getContextPath());
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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <%--表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <%--使用c：foreach 遍历后端发来的数据--%>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <%--表格数据--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,共${pageInfo.pages}页,共${pageInfo.total}条记录。
            </div>
            <%--分页条--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/emps?pn=1">首页</a> </li>
                        <%--如果有上一页 再显示上一页的标识--%>
                        <c:if test="${pageInfo.hasPreviousPage==true}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                            <c:if test="${num==pageInfo.pageNum}">
                                <li class="active"><a href="${APP_PATH}/emps?pn=${num}">${num}</a></li>
                            </c:if>
                            <c:if test="${num!=pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${num}">${num}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage==true}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a> </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
