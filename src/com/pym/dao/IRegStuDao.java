package com.pym.dao;

import com.pym.entity.Student;

import java.util.List;

/**
 * Created by 彭奕铭 on 2018/4/22.
 */
public interface IRegStuDao {
    void regStudent(Student student);

    long checkId(Integer id);

    List getAllMaj();

    List getAllAca();
}
