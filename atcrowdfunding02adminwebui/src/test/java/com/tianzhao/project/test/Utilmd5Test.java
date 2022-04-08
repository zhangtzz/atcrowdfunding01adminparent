package com.tianzhao.project.test;

import com.tianzhao.crowd.util.CrowdUtil;
import org.junit.Test;

public class Utilmd5Test {
    @Test
    public void  testMd5(){
        String sorce = "123123";
        String s = CrowdUtil.md5(sorce);
        System.out.println(s);

    }
}
