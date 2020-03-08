package com.pym.service;

import com.pym.dao.IRegStuDao;
import com.pym.entity.Academy;
import com.pym.entity.Major;
import com.pym.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 彭奕铭 on 2018/4/22.
 */
@Service
public class RegStuService {
    @Autowired
    IRegStuDao iRegStuDao;

    public void regStu(Student student) {
        iRegStuDao.regStudent(student);
    }

    public boolean checkId(Integer id) {
        long count = iRegStuDao.checkId(id);
        return count ==0;
    }

    public List<Major> getMaj() {
        List<Major> list = iRegStuDao.getAllMaj();
        return list;
    }

    public List<Academy> getAca() {
        List<Academy> list = iRegStuDao.getAllAca();
        return list;
    }
}
