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
<link rel="stylesheet" href="css/pagination.css">
<link rel="stylesheet" href="ztree/zTreeStyle.css"/>
<script type="text/javascript" src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="jquery/jquery.pagination.js"></script>
<script type="text/javascript" src="crowd/my-role.js"></script>
<script type="text/javascript">
    $(function () {
        // 1.为分页操作准备初始化数据
        window.pageNum=1;
        window.pageSize = 5 ;
        window.keyword = "";
        generatePage();

        $("#searchBtn").click(function () {

            window.keyword = $("#keywordInput").val();
            generatePage();
        });

        // 点击新增按钮打开模态框
        $("#showAddModalBtn") .click(function () {
            $("#addModel").modal("show");
            return false;
        });
        
        $("#saveRoleBtn").click(function () {
            var roleName =$.trim($("#addModel [name =roleName]").val());
            $.ajax({
                "url" :"role/save.json" ,
                "type" :"post",
                "data" : {
                    "name" :roleName
                },
                "dataType" :"json" ,
                "success" :  function (response) {
                    var result = response.result;
                    if(result == "SUCCESS"){
                        layer.msg("操作成功！")

                        window.pageNum = 99999;
                        generatePage();
                    }
                    if(result == "FAILED"){
                        layer.msg("操作失败！"+response.message) ;
                    }
                } ,
                "error "  : function (response) {
                    layer.msg(response.status + " " +response.statusText);
                }
            });
            $("#addModel").modal("hide")
            $("#addModel [name = roleName]").val("");
            //重新加载分页

        }),
        /**
         *使用jQuery对象的on()函数可以解决上面的问题
         * 1.先找到所有的“动态生成” 的元素所附着的“静态” 元素
         * 2.on() 函数的第一个参数是事件类型
         * 3.on() 函数的第二个参数是找到真正的要绑定事件的元素的元素选择器
         * 4.on() 函数的第三个参数是事件响应的单击函数
         */

        $("#rolePageBody").on("click",".pencilBtn" , function () {
            // 打开模态框
            $("#updateModel").modal("show");
            // 获取表格中的当前行的角色名称
            var roleName = $(this).parent().prev().text();
            /**
             *  获取当前角色的Id
             *  一句是之前设置了pencilBtn按钮的Id属性值为角色Id   var pencilBtn ="<button  type='button' id='"+roleId+"' class='pencilBtn btn btn-primary btn-xs'><i class=' glyphicon glyphicon-pencil'></i></button>";
             *  为了让执行更新的按钮能够获取到roleId的值，把它放在全局变量上
             */
             window.roleId = this.id;

            $("#updateModel [name = roleName]").val(roleName);

        });
        $("#updateRoleBtn").click(function () {
            // 1. 从文本框中 获取新的角色名称
            var roleName = $("#updateModel [name = roleName]").val();
            // 2.  发送aJAx请求执行更新
            $.ajax({
                "url":"role/update.json",
                "type":"post",
                "data" :{
                    "id" :window.roleId,
                    "name" : roleName
                },
                "dataType" : "json",
                "success" :  function (response) {
                    var result = response.result;
                    if(result == "SUCCESS"){
                        layer.msg("操作成功！")
                        // 重新加载分页数据
                        generatePage();
                    }
                    if(result == "FAILED"){
                        layer.msg("操作失败！"+response.message) ;
                    }
                } ,
                "error "  : function (response) {
                    layer.msg(response.status + " " +response.statusText);
                }

            });
            $("#updateModel").modal("hide");
        })
        // 点击确认模态框中的确认删除按钮删除
        $("#removeRoleBtn").click(function () {
            var requestBody = JSON.stringify(window.roleIdArray);
            $.ajax({
                "url" : "role/remove/by/role/id/array.json",
                "type" : "post",
                "data" : requestBody,
                "contentType" :"application/json;charset=UTF-8" ,
                "success" :  function (response) {
                    var result = response.result;
                    if(result == "SUCCESS"){
                        layer.msg("操作成功！")
                        // 重新加载分页数据
                        generatePage();
                    }
                    if(result == "FAILED"){
                        layer.msg("操作失败！"+response.message) ;
                    }
                } ,
                "error "  : function (response) {
                    layer.msg(response.status + " " +response.statusText);
                }
            });
            // 关闭模态框
            $("#confirmModel").modal("hide");
        });
        $("#rolePageBody").on("click",".removeBtn",function () {
            var roleName = $(this).parent().prev().text();
            var roleArray= [{
                roleId : this.id,
                roleName : roleName
            }];
            showCOnfirmModal(roleArray)
        });
        // 全选全不选功能
        // 给总的checkbox绑定单击响应函数
        $("#summaryBox").change(function(){
            // 1.获取当前多选框自身的状态
            var currentStatus = this.checked;
            // 2. 用当前多选框的状态设置其他多选框itemBox
            $(".itemBox").prop("checked",currentStatus);
        });
        $("#rolePageBody").on("click",".itemBox",function (){
            //  获取当前已经选中的itemBox的数量
            var checkedBoxCount = $(".itemBox:checked").length;
            // 获取全部itemBox 的数量
            var totalBoxCount = $(".itemBox").length;
            //使用两者的比较结果来设置总的checkBox
            $("#summaryBox").prop("checked",checkedBoxCount==totalBoxCount);
        });
        //  给批量删除的 按钮绑定单击相应函数
        $("#batchRenoveBtn").click(function (){
            // 创建一个数组对象来存放后面获取到的角色对象
            var roleArray = [];
            $(".itemBox:checked").each(function (){
                // 使用this引用当前遍历得到的多选框
               var roleId  = this.id;
               // 通过DOM操作获取角色名称
                var roleName = $(this).parent().next().text();
                roleArray.push({
                    "roleId" :  roleId,
                    "roleName" : roleName
                });
            });
            if(roleArray.length==0){
                layer.msg("请至少选择一个执行删除！！！")
                return;
            }
            showCOnfirmModal(roleArray);

        });
        // 给分配权限按钮绑定单击函数
        $("#rolePageBody").on("click",".checkBtn",function (){
            // 打开模态框
            $("#assignModal").modal("show");
            fillAuthTree();
        })




    });
</script>
<body>
<%@include file="include-nav.jsp"%>
<div class="container-fluid">
    <div class="row">
        <%@include file="include-sidbar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                 <div class="input-group-addon">查询条件</div>
                                <input id="keywordInput" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="searchBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="batchRenoveBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button"
                            id="showAddModalBtn"
                            class="btn btn-primary"
                            style="float:right;" >
                        <i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" id="summaryBox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="rolePageBody">
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <div id="Pagination" class="pagination"><!--这里显示导航条--></div>
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
<%@include file="model-role-add.jsp"%>
<%@include file="model-role-edit.jsp"%>
<%@include file="model-role-confirm.jsp"%>
<%@include file="modal-role-assign-auth.jsp"%>
</body>
</html>