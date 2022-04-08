package com.tianzhao.crowd.service.impl;

import com.tianzhao.crowd.entity.Auth;
import com.tianzhao.crowd.entity.AuthExample;
import com.tianzhao.crowd.mapper.AuthMapper;
import com.tianzhao.crowd.service.api.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthserviceImpl implements AuthService {
    @Autowired
    private AuthMapper authMapper;

    @Override
    public List<Auth> getAll() {

        return authMapper.selectByExample(new AuthExample());
    }
}
