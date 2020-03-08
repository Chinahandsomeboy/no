package com.pym.entity;

/**
 * Created by 彭奕铭 on 2018/5/3.
 */
public class Academy {

    private String aid;
    private String aname;

    @Override
    public String toString() {
        return "Academy{" +
                "aid='" + aid + '\'' +
                ", aname='" + aname + '\'' +
                '}';
    }

    public String getAid() {
        return aid;
    }

    public void setAid(String aid) {
        this.aid = aid;
    }

    public String getAname() {
        return aname;
    }

    public void setAname(String aname) {
        this.aname = aname;
    }

    public Academy() {

    }

    public Academy(String aid, String aname) {

        this.aid = aid;
        this.aname = aname;
    }
}
