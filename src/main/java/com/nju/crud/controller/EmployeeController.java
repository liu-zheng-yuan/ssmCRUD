package com.nju.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.nju.crud.bean.Employee;
import com.nju.crud.bean.Msg;
import com.nju.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
* 处理员工curd请求
* */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

//  返回一个json格式的查询员工数据
//  需要导入jsckson包，实现MessageConvorter将java对象转换成json格式
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //      引入pageHelper进行分页查询
//      在插循之前只需要调用以下方法 传入页码以及每页大小
        PageHelper.startPage(pn,5);
//      startPage后面紧跟的查询就是个分页查询
        List<Employee> emps=employeeService.getAll();
//      用PageInfo包装查出来的结果,只需要将pageinfo交给页面
//      它封装了详细的分页信息，第二个参数是连续显示的页数
        PageInfo page=new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }


    //  保存提交的信息,返回成功与否
//  检查用户名是否重复

    /*
    * 需要用jsr303进行重要数据后端校验
    * 导入hibernate-valid的包
    *
    * */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
//          保存错误信息
            Map<String,Object> map=new HashMap<>();
//          校验失败 返回失败，在模态框中显示校验失败的错误信息
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                System.out.println("错误的字段名 " + fieldError.getField());
                System.out.println("错误信息 "+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping(value = "/checkuser")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName") String empName){
//      先判断用户名是否是合法的表达式 用正则
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名可以是2-5位中文或6-16位英文和数字的组合");
        }
//      数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }

    }

    //查询单个员工信息
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);

    }

    //保存员工修改
    //占位符empId自动赋给POJO入参employee的empId属性（必须要同名）
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    //  删除单一或是多个员工
    //批量删除 传入 1-2-3
    //单个删除 传入单个id
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if(ids.contains("-")){
            List<Integer> del_id=new ArrayList<>();
            String[] str_ids=ids.split("-");
            //组装id的集合
            for(String id : str_ids){
                del_id.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_id);
            return Msg.success();
        }else{
            employeeService.deleteEmpById(Integer.parseInt(ids));
            return Msg.success();
        }
    }


//  查询员工数据，分页查询 非json版本 不使用
    /*
    //@RequestMapping("/emps")

    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
//      引入pageHelper进行分页查询
//      在插循之前只需要调用以下方法 传入页码以及每页大小
        PageHelper.startPage(pn,5);
//      startPage后面紧跟的查询就是个分页查询
        List<Employee> emps=employeeService.getAll();
//      用PageInfo包装查出来的结果,只需要将pageinfo交给页面
//      它封装了详细的分页信息，第二个参数是连续显示的页数
        PageInfo page=new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }
    * */
}
