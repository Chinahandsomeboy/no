package com.pym.controller;

import com.pym.entity.Admin;
import com.pym.entity.Msg;
import com.pym.entity.Student;
import com.pym.service.IAdminService;
import com.pym.service.IStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by pym on 16/6/22.
 */

@Controller
public class LoginController {

    @Autowired
    private IStudentService studentService;

    @Autowired
    private IAdminService adminService;

    @RequestMapping("/login")
    public String userLogin(@RequestParam String id, @RequestParam String pwd, HttpServletRequest req) {
        Student student = null;
        if (id.length() > 0 && id.length() < 20 && pwd.length() > 0 && pwd.length() < 20) {
            student = studentService.login(id, pwd);
        }
        if (student != null) {
            req.getSession().setAttribute("user", student.getName());
            req.getSession().setAttribute("userId", student.getId());
//            req.getSession().setAttribute("msg","登录成功!欢迎您 "+student.getName()+"!");
        } else {
            req.getSession().setAttribute("msg", "登录失败!用户名或密码错误!");
        }
        return "redirect:/index";
    }

    @RequestMapping("/logout")
    public String userLogout(HttpServletRequest req) {
        req.getSession().setAttribute("user", null);
        req.getSession().setAttribute("userId", null);
        return "redirect:/index";
    }

    @RequestMapping("/changePwd")
    public String changePwd(HttpServletRequest req, @RequestParam String old,
                            @RequestParam String newpwd, @RequestParam String newagain) {

        String stuId = (String) req.getSession().getAttribute("userId");
        if (newpwd.equals(newagain) && studentService.changePwd(stuId, old, newpwd)) {
            req.getSession().setAttribute("msg", "修改成功!");
        } else {
            req.getSession().setAttribute("msg", "修改失败!");
        }
        return "redirect:/index";
    }


    @RequestMapping(value = "/adminLogin",method = RequestMethod.POST)
    @ResponseBody
    public Msg adminLogin(Admin admin, HttpServletRequest req) {
        System.out.println(admin);
        if (adminService.login(admin.getUsername(), admin.getPwd())) {
            req.getSession().setAttribute("id", admin.getUsername());
            System.out.println("管理员登录成功");
            return Msg.success();
        } else {
            System.out.println("失败");
            return Msg.fail();
        }
    }

/*
    @RequestMapping(value = "/adminLogin",method = RequestMethod.POST)
    @ResponseBody

        以下这种是给原生form提交的方法

    public Msg adminLogin2(@RequestParam String username,@RequestParam String pwd, HttpServletRequest req) {
        if (adminService.login(username, pwd)) {
            req.getSession().setAttribute("id", username);
            System.out.println("管理员登录成功66666666666");
            return Msg.success();
        } else {
            System.out.println("失败");
            return Msg.fail();
        }
    }
    */
    /*
    @RequestMapping("/adminLogin")
    public String adminLogin(@RequestParam String username,@RequestParam String pwd,HttpServletRequest req){
        if (username.length() > 0 && username.length() < 20 && pwd.length() > 0 && pwd.length() < 20) {
            if(adminService.login(username, pwd)){
                req.getSession().setAttribute("id",username);
                return "redirect:adminIndex";
            }
        }
        return "adminLogin";
    }
     */

}
