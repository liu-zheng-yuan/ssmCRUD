package com.nju.crud.test;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.nju.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/*
* 使用springtest模块提供的测试请求功能，得到返回值，测试curd请求的正确性，
* 坑：SPring4测试的时候需要servlet3.0的支持
* */
@RunWith(value = SpringJUnit4ClassRunner.class)
//一般自动装配的是bean，如果需要装配ioc容器本身，要用这个注解
@WebAppConfiguration
//还需要传入springmvc的配置文件，因为在webinf文件夹下，所以直接以file：开头写全路径名
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
//  传入springmvc的iod容器本身
    @Autowired
    WebApplicationContext context;
    //  虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before//每次测试之前都需要初始化，用before标注
    public void initMokcMcx() {
//      要初始化mockmvc对象，需要mvc的ioc容器本身
        this.mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        /*模拟请求拿到返回值
        * .perform()模拟发送请求
        * requestbuilder建立请求
        * get请求对应get方法
        * .param带请求参数，多个参数的话要传入Map
        * .andreturn()获取返回值
        * */
        MvcResult result=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1"))
                .andReturn();

        //请求成功之后，请求域中会有pageinfo，可以取出验证
        MockHttpServletRequest request =result.getRequest();
        PageInfo pi=(PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码" + pi.getPageNum());
        System.out.println("总页码" + pi.getPages());
        System.out.println("总记录数" + pi.getTotal());
        int[] nums=pi.getNavigatepageNums();
        for(int i : nums){
            System.out.println(" "+ i);
        }
        List<Employee> list=pi.getList();
        for(Employee e:list){
            System.out.println(e);
        }
    }
}
