package com.tianzhao.crowd.mvc.handler;

import com.tianzhao.crowd.entity.Auth;
import com.tianzhao.crowd.entity.Role;
import com.tianzhao.crowd.service.api.AdminService;
import com.tianzhao.crowd.service.api.AuthService;
import com.tianzhao.crowd.service.api.RoleService;
import com.tianzhao.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class AssignHandler {
    @Autowired
    private AdminService adminService;

    @Autowired
    private AuthService authService;

    @Autowired
    private RoleService roleService;

    @ResponseBody
    @RequestMapping("assign/get/all/auth.json")
    public ResultEntity<List<Auth>> getAllAuth(){
        List<Auth> authList= authService.getAll();
        return ResultEntity.successWithoutData(authList);
    }

    @RequestMapping("assign/to/assign/role.page.html")
    public String toAssignRolePage(@RequestParam("adminId")Integer adminId ,ModelMap modelMap){
        List<Role> assignroleList = roleService.getAssignedRole(adminId);

        List<Role> unAssignroleList = roleService.getUnAssignedRole(adminId);

        modelMap.addAttribute("assignroleList",assignroleList);
        modelMap.addAttribute("unAssignroleList",unAssignroleList);

        return "assign-role";
    }

    @RequestMapping("assign/do/role/assign.html")
    public String saveAdminRoleRelationship(
                @RequestParam("adminId")Integer adminId,
                @RequestParam("pageNum")Integer pageNum,
                @RequestParam("keyword")String keyword,
                @RequestParam(value = "roleIdList" ,required = false) List<Integer> roleIdList
    ){
        adminService.saveAdminRoleRelationship(adminId,roleIdList);
        return "redirect:/admin/get/page.html?pageNum=+"+pageNum+"&keyword="+keyword;
    }
}
