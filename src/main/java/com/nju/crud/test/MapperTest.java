package com.nju.crud.test;
import com.nju.crud.bean.Department;
import com.nju.crud.bean.Employee;
import com.nju.crud.dao.DepartmentMapper;
import com.nju.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

//测试dao层
//如果要引入junit，需要把包设置为test或者将Maven配置文件中junit的scope不设为test
//推荐使用spring的单元测试，可以自动注入需要的组件
/*
* 导入springtest模块
* 使用@ContextConfiguration的注解指定spring配置文件的路径（可以传入多个路径）
* 使用junit的runwith注解指定使用哪个单元测试组件
* 使用@autowird装配要使用的组件即可
* */

@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    /*
    * 测试departmentMapper
    * */
    @Test
    public void testCrud() {
//      departmentMapper.insertSelective(new Department(null,"开发部"));
//      departmentMapper.insertSelective(new Department(null,"测试部"));
//      employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@163.com",1));
//      使用可以批量操作的sqlsession，需要在applicationContext配置一个可以批量执行的sqlSession
//      从这个sqlSession拿到的Mapper可以执行批量操作
        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<1000;i++){
            String uid= UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@163.com",1));

        }
        System.out.println("ok");
    }
}
