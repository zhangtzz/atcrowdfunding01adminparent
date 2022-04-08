package com.tianzhao.crowd.mvc.interceptor;

import com.tianzhao.crowd.constant.CrowdConstant;

import com.tianzhao.crowd.entity.Admin;
import com.tianzhao.crowd.exception.AccessForbiddenException;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    /**
     * 拦截器方法 判断是否为登录状态
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 1.获取sesssion对象
        HttpSession session = request.getSession();
        // 2.在session域中获取admin的对象
        Admin admin = (Admin) session.getAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN);
        // 3.判断admin对象是否为空
        if(admin ==null){
            // 4. 空抛出异常
            throw  new AccessForbiddenException(CrowdConstant.MESSAGE_ACCESS_FORBIDEN);
        }
        // 5.不为空返回true放行
        return true;
    }
}
