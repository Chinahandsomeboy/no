package com.pym.Test;

import com.pym.dao.IRegStuDao;
import com.pym.entity.Student;
import org.aspectj.apache.bcel.util.ClassPath;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by 彭奕铭 on 2018/4/23.
 * 测试dao层的功能
 *
 * 测试regstudao的功能
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    IRegStuDao iRegStuDao;
    @Test
    public void testCRUD(){
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        IRegStuDao bean = ioc.getBean(IRegStuDao.class);
        iRegStuDao.regStudent(new Student("222","222","彭奕铭",'M',"2014","计算机科学与技术"));
    }
}
