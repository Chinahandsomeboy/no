package com.pym.dao.Impl;

import com.pym.dao.IClzDao;
import com.pym.entity.Course;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 功能描述:
 *
 * @Author pym
 * @Date 16/7/6.
 */

@Repository
public class ClzDao extends SqlSessionDaoSupport implements IClzDao {

    private static final String SQL_NAMESPACE = "Clz";

    @Override
    public List<Course> selectAll() {
        return this.getSqlSession().selectList(SQL_NAMESPACE + ".selectAll");
    }

    @Override
    public Course selectById(Integer id) {

        return this.getSqlSession().selectOne(SQL_NAMESPACE + ".selectById", id);
    }

    @Override
    public void update(Course course) {
        this.getSqlSession().update(SQL_NAMESPACE + ".update", course);
    }
}
