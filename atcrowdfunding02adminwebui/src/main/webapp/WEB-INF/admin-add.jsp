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
                <li class="active">新增</li>
            </ol>

            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form" action="${pageContext.request.contextPath}/admin/save.html" method="post" role="form">
                        <p>${requestScope.exception.message}</p>
                        <div class="form-group">
                            <label for="exampleInputPassword1">登录账号</label>
                            <input
                                    type="text"
                                    name="loginAcct"
                                    class="form-control" id="exampleInputPassword2" placeholder="请输入登录账号">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">登录密码</label>
                            <input
                                    type="text"
                                    name="userPswd"
                                    class="form-control" id="exampleInputPassword1" placeholder="请输入登录密码">
                        </div>
                        <div class="form-group">

                            <label for="exampleInputPassword1">用户昵称</label>
                            <input type="text"
                                    name="userName"
                                   class="form-control" id="exampleInputPassword3" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">邮箱地址</label>
                            <input type="email" name="email" class="form-control" id="exampleInputEmail1" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>