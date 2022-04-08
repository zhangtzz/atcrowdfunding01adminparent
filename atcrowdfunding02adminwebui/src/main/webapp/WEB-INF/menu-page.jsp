<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/3/28
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<%@include file="include-head.jsp"%>
<link rel="stylesheet" href="ztree/zTreeStyle.css"/>
<script type="text/javascript" src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="crowd/my-menu.js"></script>
<script type="text/javascript">
    $(function (){

        generateTree();
        $("#treeDemo").on("click",".addBtn",function (){
            window.pid = this.id;
            $("#menuAddModal").modal("show");
            return false;
        })
        $("#menuSaveBtn").click(function (){
            //  收集表单项用户输入的数据
            var  name = $.trim($("#menuAddModal [name = name]").val());
            var url =$.trim($("#menuAddModal [name = url]").val());
            var icon =$.trim($("#menuAddModal [name = icon]:checked").val());
            $.ajax({
                "url":"menu/save.json",
                "type" :"post" ,
                "data" :{
                    "pid"  : window.pid,
                    "name": name,
                    "url" :url,
                    "icon" :icon
                },
                "dataType" :  "json" ,
                "success" : function (response){
                    var result = response.result;
                    if(result == "SUCCESS"){
                        layer.msg("操作成功");
                        generateTree();
                    }
                    if (result == "FAILED"){
                        layer.msg("操作失败！"+response.message);
                    }
                },
                "error" : function (response){
                    layer.msg(response.status+" " +response.statusText);
                }
            });
            // 关闭模态框
             $("#menuAddModal").modal("hide");
            // 重新加载树形结构

             //  清空表单：jQery对象调用click（）函数，里面不传任何参数，
            //  相当于用户点击了一下
            $("#menuResetBtn").click();
        });


        $("#treeDemo").on("click",".editBtn",function (){
            window.id = this.id;
            $("#menuEditModal").modal("show");
            //  获取zTreeObj这个 对象
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");
            var key = "id" ;
            var value =  window.id;
            var currentNode =  zTreeObj.getNodeByParam(key,value);
            $("#menuEditModal [name = name]").val(currentNode.name)
            $("#menuEditModal [name = url]").val(currentNode.url)
            $("#menuEditModal [name = icon]").val([currentNode.icon])

            return false;
        });

        $("#menuEditBtn").click(function () {
            var id = window.id;
            var  name = $.trim($("#menuEditModal [name = name]").val());
            var url =$.trim($("#menuEditModal [name = url]").val());
            var icon =$.trim($("#menuEditModal [name = icon]:checked").val());
            $.ajax({
                "url":"menu/edit.json",
                "type" :"post" ,
                "data" :{
                     "id":  id,
                    "name": name,
                    "url" :url,
                    "icon" :icon
                },
                "dataType" :  "json" ,
                "success" : function (response){
                    var result = response.result;
                    if(result == "SUCCESS"){
                        layer.msg("操作成功");
                        generateTree();
                    }
                    if (result == "FAILED"){
                        layer.msg("操作失败！"+response.message);
                    }
                },
                "error" : function (response){
                    layer.msg(response.status+" " +response.statusText);
                }
            });
            // 关闭模态框
            $("#menuEditModal").modal("hide");
        });

        $("#treeDemo").on("click",".removeBtn",function (){
            window.id = this.id;
            $("#menuConfirmModal").modal("show");
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");
            var key = "id" ;
            var value =  window.id;
            var currentNode = zTreeObj.getNodeByParam(key,value);
            $("#removeNodeSpan").html("【<i class='"+currentNode.icon+"'></i>"+currentNode.name+"】");
            return false;
        });
        $("#confirmBtn").click(function (){
            $.ajax({
                "url": "menu/remove.json",
                "type" : "POST",
                "data" : {
                    "id": window.id
                },
                "dataType" :"json",
                "success" : function (response){
                    var result = response.result;
                    if(result == "SUCCESS"){
                        layer.msg("操作成功");
                        generateTree();
                    }
                    if (result == "FAILED"){
                        layer.msg("操作失败！"+response.message);
                    }
                },
                "error" : function (response){
                    layer.msg(response.status+" " +response.statusText);
                }
            })
            $("#menuConfirmModal").modal("hide");
        })



    })

</script>
<body>

<%@ include file="/WEB-INF/include-nav.jsp"%>
<div class="container-fluid">
    <div class="row">
        <%@ include file="include-sidbar.jsp"%>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
                    <div style="float: right; cursor: pointer;" data-toggle="modal"
                         data-target="#myModal">
                        <i class="glyphicon glyphicon-question-sign"></i>
                    </div>
                </div>
                <div class="panel-body">

                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/modal-menu-add.jsp" %>
<%@include file="modal-menu-confirm.jsp" %>
<%@include file="modal-menu-edit.jsp" %>
</body>
</html>