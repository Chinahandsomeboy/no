package com.pym.entity;

/**
 * Created by 彭奕铭 on 2018/4/25.
 */
public class Major {
    private int mid;
    private String mname;

    @Override
    public String toString() {
        return "Major{" +
                "mid=" + mid +
                ", mname='" + mname + '\'' +
                '}';
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public Major(int mid, String mname) {

        this.mid = mid;
        this.mname = mname;
    }

    public Major() {

    }
}
