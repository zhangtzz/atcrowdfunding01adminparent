package com.tianzhao.crowd.service.api;



import com.github.pagehelper.PageInfo;
import com.tianzhao.crowd.entity.Role;

import java.util.List;

public interface RoleService {
    PageInfo<Role> getPageInfo(Integer pageNum, Integer pageSize, String keyword);

    void saveRole(Role role);

    void updateRole(Role role);



    void removeRole(List<Integer>  roleId );


    List<Role> getAssignedRole(Integer adminId);

    List<Role> getUnAssignedRole(Integer adminId);
}
