package com.tianzhao.project.test;

import com.tianzhao.crowd.entity.Admin;

import com.tianzhao.crowd.entity.Menu;
import com.tianzhao.crowd.entity.Role;
import com.tianzhao.crowd.mapper.AdminMapper;
import com.tianzhao.crowd.mapper.RoleMapper;
import com.tianzhao.crowd.service.api.AdminService;
import com.tianzhao.crowd.service.api.MenuService;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;


//在spring整合junit
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-persist-tx.xml","classpath:spring-persist-mybatis.xml"})
public class test {
    @Autowired
    private DataSource dataSource;
    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private AdminService adminService ;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private MenuService menuService;
    @Test
    public void test11(){
        List<Menu> all = menuService.getAll();
        System.out.println(all);
    }

    @Test
    public void test6(){
        for (int i= 0 ;i< 235 ; i++){
            roleMapper.insert(new Role(null,"role"+i));
        }
    }

    @Test
    public void test1(){
        for(int i= 0 ;i<269;i++) {
            Admin admin = new Admin(null, "jerry"+i, "123456", "杰瑞"+i, "jerry@qq.com"+i, null);
            adminService.saveAdmin(admin);
        }
    }

    @Test
    public void test2() throws SQLException {
        Connection connection = dataSource.getConnection();
        System.out.println(connection);



    }



















}
