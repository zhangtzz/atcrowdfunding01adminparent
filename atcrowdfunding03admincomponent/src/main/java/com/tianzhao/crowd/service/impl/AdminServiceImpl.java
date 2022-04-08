package com.tianzhao.crowd.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tianzhao.crowd.constant.CrowdConstant;

import com.tianzhao.crowd.entity.Admin;
import com.tianzhao.crowd.entity.AdminExample;
import com.tianzhao.crowd.exception.LoginAcctAlreadyForUpdateException;
import com.tianzhao.crowd.exception.LoginAcctAlreadyInUseException;
import com.tianzhao.crowd.exception.LoginFaileException;
import com.tianzhao.crowd.mapper.AdminMapper;
import com.tianzhao.crowd.service.api.AdminService;
import com.tianzhao.crowd.util.CrowdUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void saveAdmin(Admin admin) {
        String userPswd = admin.getUserPswd();
        userPswd = CrowdUtil.md5(userPswd);
        admin.setUserPswd(userPswd);
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String format1 = format.format(date);
        admin.setCreateTime(format1);


        try {
            adminMapper.insert(admin);
        }catch (Exception e ){
            if(e instanceof DuplicateKeyException){
                throw new LoginAcctAlreadyInUseException(CrowdConstant.MESSAGE_LOGIN_ACCT_ALREADY_IN_USE);
            }
        }



    }

    @Override
    public List<Admin> getAll() {
        List<Admin> admins = adminMapper.selectByExample(new AdminExample());
        admins.forEach(admin -> System.out.println(admin));
        return admins;
    }

    @Override
    public Admin getAdminByLoginAcct(String loginAcct, String userPswd) {
        if(loginAcct==null){
            throw new LoginFaileException(CrowdConstant.MESSAGE_LOGIN_ACCT_NULL);
        }
        AdminExample adminExample = new AdminExample();
         AdminExample.Criteria criteria = adminExample.createCriteria();
        AdminExample.Criteria criteria1 = criteria.andLoginAcctEqualTo(loginAcct);

        List<Admin> admins = adminMapper.selectByExample(adminExample);
        if(admins==null || admins.size()==0){
            throw new LoginFaileException(CrowdConstant.MESSAGE_LOGIN_ACCR_ALREADY);
        }
        if(admins.size()>1){
            throw new RuntimeException(CrowdConstant.MESSAGE_SYSTEM_ERROR_LOGIN_NOT_UNIQUE);
        }
        Admin admin  = admins.get(0);
        if(admin == null){throw new LoginFaileException(CrowdConstant.MESSAGE_LOGIN_FATLED); }
        String userPswdDB = admin.getUserPswd();
        String userPswdFrom = CrowdUtil.md5(userPswd);
        if(!Objects.equals(userPswdDB,userPswdFrom)){
            throw  new LoginFaileException(CrowdConstant.MESSAGE_LOGIN_FATLED);
        }
        return admin;
    }

    @Override
    public PageInfo<Admin> getPageInfo(String keyword, Integer pageNum, Integer pageSize) {
        // 1. 调用pageHelper的静态方法开启分页功能
        PageHelper.startPage(pageNum,pageSize);
        // 2.执行查询
        List<Admin> admins = adminMapper.selectAdminByKeyword(keyword);
        // 3.封装到PageInfo对象中
        return new PageInfo<>(admins);

    }

    @Override
    public void remove(Integer adminId) {
        adminMapper.deleteByPrimaryKey(adminId);
    }

    @Override
    public Admin getAdminById(Integer adminId) {
        Admin admin = adminMapper.selectByPrimaryKey(adminId);
        return admin;
    }

    @Override
    public void update(Admin admin) {
        try {
            adminMapper.updateByPrimaryKeySelective(admin);
        }catch (Exception e ){
            e.printStackTrace();
            if(e instanceof DuplicateKeyException)
                throw new LoginAcctAlreadyForUpdateException(CrowdConstant.MESSAGE_SYSTEM_ERROR_LOGIN_NOT_UNIQUE);
        }

    }

    @Override
    public void saveAdminRoleRelationship(Integer adminId, List<Integer> roleIdList) {
        adminMapper.deleteOldRelationship(adminId);
        if(roleIdList != null &&roleIdList.size() >0){
            adminMapper.insertNewRealationship(adminId,roleIdList);
        }

    }
}
