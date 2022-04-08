package com.tianzhao.crowd.mvc.handler;

import com.github.pagehelper.PageInfo;

import com.tianzhao.crowd.entity.Role;
import com.tianzhao.crowd.service.api.RoleService;
import com.tianzhao.crowd.util.ResultEntity;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
public class RoleHandler {
    @Autowired
    private RoleService roleService;


    @RequestMapping("/role/remove/by/role/id/array.json")
    public ResultEntity<String> removeByRoleIdArry(@RequestBody List<Integer> roleList ){
        System.out.println(Arrays.toString(new List[]{roleList}));
        roleService.removeRole(roleList);
        return ResultEntity.successWithoutData();
    }


    @RequestMapping("role/update.json")
    public ResultEntity<String> updateRole(Role role){
//        System.out.println(role);
        roleService.updateRole(role);
        return ResultEntity.successWithoutData();
    }

    @RequestMapping("role/save.json")
    public ResultEntity<String> saveRole(Role role){

        roleService.saveRole(role);
        return ResultEntity.successWithoutData();
    }


    @RequestMapping("/role/get/page/info.json")
    public ResultEntity<PageInfo<Role>> getPageInfo(
                                @RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum,@RequestParam(value = "pageSize",defaultValue = "5")Integer poageSize,
                                @RequestParam(value = "keyword",defaultValue = "")String keyword
                                    ){
        PageInfo<Role>  pageInfo = roleService.getPageInfo(pageNum, poageSize, keyword);
            return ResultEntity.successWithoutData(pageInfo);
        }



}


