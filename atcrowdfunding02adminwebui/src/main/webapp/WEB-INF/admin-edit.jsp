<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/3/28
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<%@include file="include-head.jsp" %>
<body>
<%@include file="include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@include file="include-sidbar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="/admin/to/main/page.html">首页</a></li>
                <li><a href="/admin/get/page.html">数据列表</a></li>
                <li class="active">修改</li>
            </ol>

            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form" action="${pageContext.request.contextPath}/admin/update.html" method="post" role="form">
                        <input type="hidden" name="id" value="${requestScope.admin.id}">
                        <input type="hidden" name="pageNum" value="${param.pageNum}" >
                        <input type="hidden" name="keyword" value="${param.keyword}" >

                        <p>${requestScope.exception.message}</p>

                        <div class="form-group">
                            <label for="exampleInputPassword1">登录账户</label>
                            <input
                                    type="text"
                                    name="userPswd" value="${admin.loginAcct}"
                                    class="form-control" id="exampleInputPassword1" placeholder="请输入修改后的账户名">
                        </div>
                        <div class="form-group">

                            <label for="exampleInputPassword1">用户昵称</label>
                            <input type="text"
                                   name="userName"
                                   class="form-control" value="${admin.userName}" id="exampleInputPassword3" placeholder="请输入修改后的用户昵称">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">邮箱地址</label>
                            <input type="email" value="${admin.email}" name="email" class="form-control" id="exampleInputEmail1" placeholder="请输入修改后的邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 提交修改</button>
                        <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>