package com.tianzhao.crowd.mvc.handler;

import com.tianzhao.crowd.entity.Menu;
import com.tianzhao.crowd.service.api.MenuService;
import com.tianzhao.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class MenuHandler {
    @Autowired
    private MenuService menuService;

    @RequestMapping("menu/remove.json" )
    public ResultEntity<String> removeMenu(@RequestParam("id")Integer id){
        menuService.removeMenu(id);
        return ResultEntity.successWithoutData();
    }

    @RequestMapping("menu/edit.json")
    public ResultEntity<String> editMenu(Menu menu){
        menuService.editMenu(menu);
        return ResultEntity.successWithoutData();
    }

    @RequestMapping("menu/save.json")
    public ResultEntity<String> saveMenu(Menu menu){
    menuService.saveMenu(menu);
    return ResultEntity.successWithoutData();
    }

    @RequestMapping("/menu/get/whole/tree.json")
    public ResultEntity<Menu> getWholeTreeNew(){
        List<Menu> menuList = menuService.getAll();
        Menu root =null;
        Map<Integer ,Menu> menuMap = new HashMap<>();
        for (Menu menu : menuList) {
            Integer id = menu.getId();
            menuMap.put(id,menu);
        }
        for (Menu menu : menuList) {
            Integer pid = menu.getPid();
            // 如果pid==null, 判定为根节点
            if(pid==null){
                root = menu;
                continue;
            }
            Menu father = menuMap.get(pid);
            father.getChildren().add(menu);

        }
        return  ResultEntity.successWithoutData(root);
    }


}
