package com.nju.crud.controller;
/*
* 处理和部门有关的请求
* */

import com.nju.crud.bean.Department;
import com.nju.crud.bean.Employee;
import com.nju.crud.bean.Msg;
import com.nju.crud.service.DepartmentService;
import com.nju.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;
    /*
    * 返回所有部门的信息
    * */

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list=departmentService.getDepts();

        return Msg.success().add("depts",list);
    }


}
