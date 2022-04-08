function generateTree(){
    $.ajax({
        "url" :"menu/get/whole/tree.json" ,
        "type" :"post" ,
        "dataType ": "json",
        "success":function (response){
            var result = response.result;
            if (result == "SUCCESS"){
                var setting ={
                    "view" :{
                        "addDiyDom" : myAddDiyDom,
                        "addHoverDom":myAddHoverDom,
                        "removeHoverDom":myRemoveHoverDom
                    },
                    "data":{
                        "key":{
                            "url" :"notdsadsdsadsa"
                        }
                    }
                };
                var zNodes = response.data;
                $.fn.zTree.init($("#treeDemo"),setting,zNodes);
            }
            if (result == "FAILED"){
                layer.msg(response.message);
            }
        }
    });
}



function myAddDiyDom(treeId,treeNode){
    console.log("treeId" + treeId);
    console.log(treeNode);

    var spanId = treeNode.tId+ "_ico";

    $("#"+spanId)
        .removeClass()
        .addClass(treeNode.icon)
}
function myAddHoverDom(treeId,treeNode){
     // 按钮组的标签结构 <span><a><i></i></a><a><i></i></a> </span>
    // 按钮组出现的位置 ： 节点中treeDemo_n_a  超链接的后面
    var btnGroupId =treeNode.tId + "_btnGrp";
    if ($("#" + btnGroupId).length > 0) {
        return;
    }
    var addBtn = "<a id='"+treeNode.id+"' class='addBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='添加节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-plus rbg '></i></a>";
    var removeBtn = "<a id='"+treeNode.id+"' class='removeBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='删除节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-times rbg '></i></a>";
    var editBtn = "<a  id='"+treeNode.id+"' class='editBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='修改节点'>&nbsp;&nbsp;<i class='fa fa-fw fa-edit rbg '></i></a>";
    //  找到附着的按钮组的超链接
    var tId = treeNode.tId+"_a";
    // 执行在超链接后面发附加span元素的操作
    var level = treeNode.level;
    var btnHTML = "";
    if(level == 0 ){
        btnHTML = btnHTML+addBtn;
    }
    if(level==1 ){
        btnHTML = addBtn+" " + editBtn;
        var lenth = treeNode.children.length;
        if (lenth==0) {
            btnHTML =btnHTML+" " + removeBtn;
        }
    }
    if(level == 2){
        btnHTML  =editBtn + " " +removeBtn ;
    }
    $("#"+tId).after("<span id='"+btnGroupId+"'>"+btnHTML+"</span>")
}

function myRemoveHoverDom(treeId,treeNode){
    var btnGroupId =treeNode.tId + "_btnGrp";
    $("#"+btnGroupId).remove()
}

