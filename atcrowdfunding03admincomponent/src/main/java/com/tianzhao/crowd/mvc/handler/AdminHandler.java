package com.tianzhao.crowd.mvc.handler;

import com.github.pagehelper.PageInfo;
import com.tianzhao.crowd.constant.CrowdConstant;

import com.tianzhao.crowd.entity.Admin;
import com.tianzhao.crowd.service.api.AdminService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class AdminHandler {
    @Autowired
    private AdminService adminService;

    @RequestMapping("admin/update.html")
    public String update(Admin admin, @RequestParam("pageNum")Integer pageNum, @RequestParam("keyword")String keyword){
        adminService.update(admin);
        return "redirect:/admin/get/page.html?pageNum="+pageNum+" &keyword= "+keyword;
    }


    @RequestMapping("admin/to/edit/page.html")
    public String toEditPage(@RequestParam("adminId")Integer adminId,@RequestParam("pageNum")Integer pageNum ,
                             @RequestParam("keyword")String keyword , ModelMap modelMap){
        Admin admin = adminService.getAdminById(adminId);
        modelMap.addAttribute("admin",admin);
        return "admin-edit";
    }

    @RequestMapping("/admin/save.html")
    public String save(Admin admin){
        adminService.saveAdmin(admin);
        return "redirect:/admin/get/page.html?pageNum="+Integer.MAX_VALUE;
    }

    @RequestMapping("/admin/remove/{adminId}/{pageNum}/{keyword}.html")
    public String remove(@PathVariable("adminId")Integer adminId,
                         @PathVariable("pageNum")Integer pageNum,
                         @PathVariable("keyword")String keyword){
        adminService.remove(adminId);
        return "redirect:/admin/get/page.html?pageNum="+pageNum+" &keyword= "+keyword;
    };




    @RequestMapping("/admin/get/page.html")
    public String getPageInfo(
            // 使用@Requestparam注解defaultValue属性，指定默认值，在请求中没有携带对应参数时使用默认值
            // keyword 默认值使用空字符串，和SQL语句配合实现两种情况适配
            @RequestParam(value = "keyword" ,defaultValue = "")String keyword,
            // pageNum 默认值使用 1
            @RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum,
            // pageSize默认值使用5
            @RequestParam(value = "pageSize",defaultValue = "5")Integer pageSize, ModelMap modelMap
            ){
        PageInfo<Admin> pageInfo = adminService.getPageInfo(keyword, pageNum, pageSize);
        modelMap.addAttribute(CrowdConstant.ATTR_NAME_PAGE_INFO,pageInfo);
        return "admin-page";

    }

    @RequestMapping("/admin/do/login.html")
    public String doLogin(@RequestParam("loginAcct")String loginAcct,
                          @RequestParam("userPswd")String userPswd , HttpSession session){

        Admin admin = adminService.getAdminByLoginAcct(loginAcct,userPswd);
        session.setAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN, admin);

        return "redirect:/admin/to/main/page.html";
    }
    @RequestMapping("admin/do/logout.html")
    public String dologout(HttpSession session){
        //强制session失效
        session.invalidate();

        return "redirect:/admin/to/login/page.html";
    }


}
