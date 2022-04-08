package com.tianzhao.crowd.service.api;

import com.tianzhao.crowd.entity.Menu;

import java.util.List;

public interface MenuService {

    List<Menu> getAll();

    void saveMenu(Menu menu);

    void editMenu(Menu menu);

    void removeMenu(Integer id);
}
