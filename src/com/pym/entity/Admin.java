package com.pym.entity;

/**
 * Created by pym on 16/6/22.
 */
public class Admin {

    //登录名
    private String id;
    //密码
    private String pwd;

    public String getUsername() {
        return id;
    }

    public void setUsername(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id='" + id + '\'' +
                ", pwd='" + pwd + '\'' +
                '}';
    }

    public Admin() {
    }

    public Admin(String id, String pwd) {

        this.id = id;
        this.pwd = pwd;
    }
}
