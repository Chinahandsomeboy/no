package com.pym.dao;

import com.pym.entity.StudyInfo;

import java.util.List;

/**
 * 功能描述:
 *
 * @Author pym
 * @Date 16/7/7.
 */
public interface IStudyInfoDao {


    public List<StudyInfo> selectByClzId(Integer clzId);

    public List<StudyInfo> selectByStuId(String stuId);

    public StudyInfo check(String stuId,Integer clzId);

    public void insert(StudyInfo studyInfo);

    public void delete(String stuId,Integer clzId);

}
