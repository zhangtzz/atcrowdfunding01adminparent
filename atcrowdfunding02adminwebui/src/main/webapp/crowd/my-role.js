/**
 *
 */
//  声明
function  fillAuthTree(){
    // 1.发送Ajax请求查询Auth的数据
     var ajaxReturn = $.ajax({
        "url" :"assign/get/all/auth.json",
        "type" : "post" ,
        "async" : false,
        "dataType" :"json"
     });
     if(ajaxReturn.status!=200){
         layer.msg("请求处理出错！响应状态码是："+ajaxReturn.status+"说明是："+ajaxReturn.statusText)
         return;
     }
         // 2.从响应结果中获取Auth的JSON数据
         // 从服务器端查询到的LIst不需要组装成树形结构，这里我们交给zTree
         var authList = response.data;
         // 3. 准备对zTree进行设置的JSON对象
         var setting = {
             "data":{
                 "simpleData": {
                     // 开启简单JSON的功能
                     "enable" :true ,
                     "pIdKey" :"categoryId"
                 },
                 "key":{
                     "name" : "title"
                 }
             }
         };
         // 4.生成树形结构
        // <ul id="authTreeDemo" class="ztree"></ul>
         $.fn.zTree.init($("#authTreeDemo"),setting,authList);
        // 5.查询已经分配的Auth的id组成的数组
        // 6.根据authIdArray把树形结构中对应的节点勾选上


}

//执行分页，生成页码效果，任何时候调用这个函数都会重新加载页码
function generatePage() {
    // 1.获取分页数据
    var pageInfo = getPageInfoRemote();
    // 2.填充表格
    fillTableBody(pageInfo);
}
//远程访问服务器端程序获取pageInfo数据
function getPageInfoRemote() {
    var  ajaxResult = $.ajax({
        "url": "role/get/page/info.json",
        "type": "post",
        "data": {
            "pageNum": window.pageNum,
            "pageSize": window.pageSize,
            "keyword": window.keyword
        },
        "async": false,
        "dataType": "json",
    });
    console.log(ajaxResult);
    var statusCode = ajaxResult.status;
    // 如果当前相应状态码不是200，说明发生了错误或其他意外情况，显示提示消息，让当前函数停止执行
    if (statusCode !=200){
        layer.msg("服务器端程序调用失败! 相应状态码是 = "+statusCode+" 说明信息 = "+ajaxResult.statusText);
        return null;
    }
    // 如果相应状态码是200 ， 说明请求成功 获取pageInfo
    var resultEntity = ajaxResult.responseJSON;
    var  result = resultEntity.result;
    if(result == "FAILED"){
        layer.msg(resultEntity.message);
        return null;
    }
    var pageInfo = resultEntity.data;
    return pageInfo;
}
// 填充表格
function fillTableBody(pageInfo) {
    $("#rolePageBody").empty();
    $("#Pagination").empty();
    // 判断pageInfo是否有效
    if(pageInfo==null||pageInfo==undefined||pageInfo.list==null||pageInfo.list.length==0){
        $("#rolePageBody").append("<tr><tdcolspan='4'align='center'>抱歉！没有查询到您搜索的数据！</td></tr>");
        return;
    }
    // 使用pageInfo的List 的属性填充tboay
    for (var i =0 ; i < pageInfo.list.length;i++){
        var role = pageInfo.list[i];
        var roleId = role.id;
        var roleName = role.name;
        var numberTd="<td>"+(i+1)+"</td>";
        var checkboxTd="<td><input id='"+roleId+"' type='checkbox' class='itemBox'></td>";
        var roleNameTd="<td>"+roleName+"</td>";
        var checkBtn = "<button type='button' id='"+roleId+"' class='checkBtn btn btn-success btn-xs'><i class=' glyphicon glyphicon-check'></i></button>";
        var pencilBtn ="<button  type='button' id='"+roleId+"' class='pencilBtn btn btn-primary btn-xs'><i class=' glyphicon glyphicon-pencil'></i></button>";
        var removeBtn = " <button type='button' id='"+roleId+"' class='removeBtn btn btn-danger btn-xs'><i class=' glyphicon glyphicon-remove'></i></button>";
        var buttonTd = "<td>"+checkBtn+" "+pencilBtn +" "+removeBtn +"</td>>"
        var tr = "<tr>"+numberTd+checkboxTd+roleNameTd+buttonTd+"</tr>"
        $("#rolePageBody").append(tr);

    }
    generateNavigator(pageInfo);
}
// 生成分页页码导航条
function generateNavigator(pageInfo) {
    var totalRecord = pageInfo.total;

    var properties = {
        "num_edge_entries" : 3,
        "num_display_entries" : 5 ,
        "callback" : pagintionCallBack,
        "items_per_page" : pageInfo.pageSize,
        "current_page" :pageInfo.pageNum-1 ,
        "prev_text" : "上一页" ,
        "next_text" : "下一页"
    }
    $("#Pagination").pagination(totalRecord,properties);
}
function pagintionCallBack(pageIndex,jQuery ) {
    window.pageNum = pageIndex+1;
    generatePage();
    return false;
}

function showCOnfirmModal(roleArray) {
    $("#confirmModel").modal("show");
    $("#roleNameDiv").empty();
    window.roleIdArray = [];
    for (var i=0 ;i<roleArray.length;i++){
        var role = roleArray[i];
        var roleName = role.roleName;
        $("#roleNameDiv").append(roleName+"<br/>");
        var roleId =role.roleId;
        window.roleIdArray.push(roleId);
    }

}



























































