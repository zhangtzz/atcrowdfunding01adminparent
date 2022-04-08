<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/3/28
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="include-head.jsp" %>
<link rel="stylesheet" href="css/pagination.css">
<script type="text/javascript" src="jquery/jquery.pagination.js"></script>
<html lang="zh-CN">
<script type="text/javascript">
    $(function () {
        // 调用后面声明的函数对页码导航条进行初始化操作
        initPagination();
    });
    function initPagination() {
        // 获取总记录数
        var totalRecord = ${requestScope.pageInfo.total}
        var properties = {
                num_edge_entries : 3,                               // 边缘页数
                num_display_entries : 5 ,                           // 主体页数
                callback:pageSelecrCallback,                      // 指定用户点击翻页的按钮跳转页面的回调函数
                items_per_page:${requestScope.pageInfo.pageSize},   // 每页要显示的数据数量
                current_page :${requestScope.pageInfo.pageNum-1},   // pagination 内部使用pageIndex 来管理也码
                prev_text : "上一页",                               // 上一页按钮上显示的文本
                next_text : "下一页"                                // 下一页按钮上显示的文本
        }
        // 生成页码导航条
        $("#Pagination").pagination(totalRecord,properties)
    }
    // 回调函数的含义，声明出来以后不是我们自己调用，而是交给系统或框架调用
    // 用户点击"上一页，下一页，1,2,3，，，，" 这样的页码时调用这个函数实现页面跳转
    function pageSelecrCallback(pageIndex ,jQuery ) {
        var pageNum = pageIndex +1;
        window.location.href = "admin/get/page.html?pageNum="+pageNum+"&keyword=${param.keyword}";
        return false;
    }
</script>
<body>
<%@include file="include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@include file="include-sidbar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form action="${pageContext.request.contextPath}/admin/get/page.html" method="post" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input name="keyword" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<%--                    <button type="button" --%>
<%--                            onclick="window.location.href='add.html'"> 新增</button>--%>
<%--                    <br>--%>
                    <a class="btn btn-primary" style="float:right;" href="${pageContext.request.contextPath}/admin/to/add/page.html"><i class="glyphicon glyphicon-plus">新增</i></a>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty requestScope.pageInfo.list}">
                                <tr>
                                    <td colspan="6" align="center"> 抱歉没有查询到您要的数据</td>
                                </tr>
                            </c:if>
                            <c:if test="${!empty requestScope.pageInfo.list}">
                                <c:forEach items="${requestScope.pageInfo.list}" var="admin" varStatus="myStatus">
                                    <tr>
                                        <td>${myStatus.count}</td>
                                        <td><input type="checkbox"></td>
                                        <td>${admin.loginAcct}</td>
                                        <td>${admin.userName}</td>
                                        <td>${admin.email}</td>
                                        <td>
<%--                                            <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>--%>
                                            <a href="assign/to/assign/role.page.html?adminId=${admin.id}&pageNum=${requestScope.pageInfo.pageNum}&keyword=${param.keyword}" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-check"></i></a>
<%--                                            <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>--%>
                                            <a href="admin/to/edit/page.html?adminId=${admin.id}&pageNum=${requestScope.pageInfo.pageNum}&keyword=${param.keyword}"
                                               class="btn btn-primary btn-xs">
                                                <i class="glyphicon glyphicon-pencil"></i> </a>
<%--                                            <button href="/admin/do" type="button" ><i class=" glyphicon glyphicon-remove"></i></button>--%>
                                            <a href="admin/remove/${admin.id}/${requestScope.pageInfo.pageNum}/${param.keyword}.html" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>



                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <div id="Pagination" class="pagination"></div>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>