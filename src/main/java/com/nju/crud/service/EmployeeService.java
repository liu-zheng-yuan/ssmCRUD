package com.nju.crud.service;

import com.nju.crud.bean.Employee;
import com.nju.crud.bean.EmployeeExample;
import com.nju.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

//  查询所有员工的业务层方法
    public List<Employee> getAll() {
        /*
        * 坑！！！
        * 两个表连接查询的结果，mysql的默认排序是先按部门类型分成几组，每组分别按id排序
        * 这会造成修改了一条记录的部门后，该记录跑到很多页之后。每个部门扎堆显示，导致顺序混乱
        * 比如前500条是开发部 后500条是测试部 修改第一条为测试部 第一条就跑到第500个的位置上
        * 即第一条记录从第一页 跑到 第n页
        * 必须传入order by emp_id
        * */
        EmployeeExample example = new EmployeeExample();
        example.setOrderByClause("e.emp_id");
        return employeeMapper.selectByExampleWithDept(example);
    }

    //  员工保存
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

//  查询员工数量 等于零返回true，代表当前用户名可用 不等于零返回false
    public boolean checkUser(String empName) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }

    /*
    * 按照员工id查询员工
    * */
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /*
    * 员工更新方法
    * */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
