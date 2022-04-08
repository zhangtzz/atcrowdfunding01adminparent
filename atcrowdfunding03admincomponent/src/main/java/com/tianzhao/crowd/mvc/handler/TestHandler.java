package com.tianzhao.crowd.mvc.handler;


import com.tianzhao.crowd.entity.Admin;
import com.tianzhao.crowd.service.api.AdminService;
import com.tianzhao.crowd.testData.Student;
import com.tianzhao.crowd.util.CrowdUtil;
import com.tianzhao.crowd.util.ResultEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class TestHandler {
    @Autowired
    private AdminService adminService;
    private Logger logger = LoggerFactory.getLogger(TestHandler.class);



    @ResponseBody
    @RequestMapping("send/compose/object.json")
    public ResultEntity<Student> test3(@RequestBody Student student,HttpServletRequest request){
        boolean b = CrowdUtil.judgeRequestType(request);
        logger.info("judgeResult = " +b);
        logger.info(student.toString());
        ResultEntity<Student> resultEntity = ResultEntity.successWithoutData(student);
        return resultEntity ;
    }

    @RequestMapping("/test/ssm.html")
    public String testSsm(ModelMap modelMap , HttpServletRequest request){
        boolean judgeResult = CrowdUtil.judgeRequestType(request);
        logger.info("judgeResult = " +judgeResult);
        List<Admin> admins = adminService.getAll();
        modelMap.addAttribute("adminList",admins);
//        String  a = null;
        int a = 10/0;
//        System.out.println(a.length());
        return "target";
    }

    @ResponseBody
    @RequestMapping("/send/array/one.html")
    public String testReceiveArrayOnde(@RequestParam("array[]") List<Integer> array){
        for (Integer number : array){
            System.out.println("numaber = " +number);
        }
        return "success";
    }
    @ResponseBody
    @RequestMapping("/send/array/three.html")
    public String testReceiveArraythree(@RequestBody List<Integer> array){



        for (Integer number : array){
            logger.info("number = "+number);

        }
        return "success";
    }



}
