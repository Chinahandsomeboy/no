package com.pym.service;

import com.pym.entity.Course;
import com.pym.entity.Student;
import com.pym.entity.StudyInfo;

import java.util.List;

/**
 * 功能描述:
 *
 * @Author pym
 * @Date 16/7/8.
 */
public interface IAdminService {
    public boolean login(String username, String pwd);

    public List<Student> getAllStudents();

    public List<Course> getAllCourses();

    public boolean updateStudent(Student student);

    public Student getStudentById(String id);

    public boolean addStudent(Student student);

    public void delStudent(String id);

    public boolean addCourse(Course course);

    public boolean updateCourse(Course course);

    public void delCourse(Integer id);

    public Course getCourseById(Integer id);

    public List<StudyInfo> getAllStudyInfo();

    public void addStudyInfo(StudyInfo studyInfo);

    public void delStudyInfo(Integer id);

    public StudyInfo getStudyById(Integer id);

}
