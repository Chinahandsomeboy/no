package com.pym.controller;

import com.pym.entity.Academy;
import com.pym.entity.Major;
import com.pym.entity.Msg;
import com.pym.entity.Student;
import com.pym.service.RegStuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * Created by pym on 16/6/22.
 */
@Controller
public class RegisterController {
    @Autowired
    RegStuService regStuService;

    @RequestMapping(value = "/regStu", method = RequestMethod.POST)
    @ResponseBody
    //@ResponseBody注解的作用是将controller的方法返回的对象通过适当的转换器转换为指定的格式之后，
    // 写入到response对象的body区，通常用来返回JSON数据或者是XML
    //!!需要导入Jackson包
    public Msg regStu(Student student, HttpServletRequest req) {
        try {
            req.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        System.out.println("运行到controller了");
        System.out.println(student);
        regStuService.regStu(student);
        System.out.println("运行了service！");
        //req.getSession().setAttribute("msg","添加成功");
        return Msg.success();
    }


    @RequestMapping(value = "/checkId/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg checkId(@PathVariable("id") Integer id) {
        //数据库查询重复的id
        System.out.println("运行到regStuService之前了");
        boolean check = regStuService.checkId(id);
        System.out.println("运行了regStuService");
        if (check) {
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

    @RequestMapping(value = "/getMaj", method = RequestMethod.GET)
    @ResponseBody
    public Msg getMajor() {
        List<Major> list = regStuService.getMaj();
        return Msg.success().add("major",list);
    }

    @RequestMapping(value = "/getAca", method = RequestMethod.GET)
    @ResponseBody
    public Msg getAca() {
        List<Academy> list = regStuService.getAca();
        System.out.println(list);
        return Msg.success().add("academy",list);
    }

    /**
     * 用id写的，那边的data：{id:id}
     *
     * @param id
     */
    @RequestMapping(value = "/checkId2", method = RequestMethod.GET)
    @ResponseBody
    public void checkId(String id) {
        //数据库查询重复的id
        System.out.println(id);

    }
}
