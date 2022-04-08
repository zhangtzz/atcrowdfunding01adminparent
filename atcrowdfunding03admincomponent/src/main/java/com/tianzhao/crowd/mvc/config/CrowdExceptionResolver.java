package com.tianzhao.crowd.mvc.config;

import com.google.gson.Gson;
import com.tianzhao.crowd.constant.CrowdConstant;
import com.tianzhao.crowd.exception.LoginAcctAlreadyForUpdateException;
import com.tianzhao.crowd.exception.LoginAcctAlreadyInUseException;
import com.tianzhao.crowd.exception.LoginFaileException;
import com.tianzhao.crowd.util.CrowdUtil;
import com.tianzhao.crowd.util.ResultEntity;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//@ControllerAdvice表示当前类是一个基于注解的异常处理器类
@ControllerAdvice
public class CrowdExceptionResolver {




    @ExceptionHandler(value = LoginAcctAlreadyForUpdateException.class)
    public ModelAndView resolveLoginAcctAlreadyForUpdateException(LoginAcctAlreadyForUpdateException exception ,
                                                    HttpServletRequest request , HttpServletResponse response) throws IOException {
        String viewName = "system-error";
        return commonResolve(viewName,exception,request,response);


    }

    @ExceptionHandler(value = LoginAcctAlreadyInUseException.class)
    public ModelAndView resolveLoginAcctAlreadyInUseException(LoginAcctAlreadyInUseException exception ,
                                                    HttpServletRequest request , HttpServletResponse response) throws IOException {
        String viewName = "admin-add";
        return commonResolve(viewName,exception,request,response);


    }

    /**
     * @param exception 实际捕获到的异常类型
     * @param request   当前请求的对象
     * @Param resonse   当前相应对象
     * @return
     */
    @ExceptionHandler(value = LoginFaileException.class)
    public ModelAndView resolveLoginFailedException(LoginFaileException exception ,
                                                    HttpServletRequest request , HttpServletResponse response) throws IOException {
        String viewName = "admin-login";
        return commonResolve(viewName,exception,request,response);


    }
    /**
     *
     * @param viewName  要去的视图
     * @param exception  实际捕获到的异常类型
     * @param request  当前请求的对象
     * @param response 当前相应对象
     * @return
     * @throws IOException
     */
    private ModelAndView commonResolve(String viewName ,Exception exception , HttpServletRequest request ,HttpServletResponse response) throws IOException {
        boolean judgeRequest = CrowdUtil.judgeRequestType(request);
        //如果是Ajax请求
        if(judgeRequest){
            ResultEntity<Object> resultEntity = ResultEntity.failed(exception.getMessage());
            Gson gson = new Gson();
            String json = gson.toJson(resultEntity);
            response.getWriter().write(json);
            return null;
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject(CrowdConstant.ATTR_NAME_EXCEPTION,exception);
        modelAndView.setViewName(viewName);

        return modelAndView;

    }
    //@ExceptionHandler 将一个具体的异常类型和一个方法关联起来

    /**
     * @param exception 实际捕获到的异常类型
     * @param request   当前请求的对象
     * @Param resonse   当前相应对象
     * @return
     */
    @ExceptionHandler(value = NullPointerException.class)
    public ModelAndView resolveNullPointerException(NullPointerException exception ,
                                                    HttpServletRequest request , HttpServletResponse response) throws IOException {
        String viewName = "system-error";
        return commonResolve(viewName,exception,request,response);


    }

}
