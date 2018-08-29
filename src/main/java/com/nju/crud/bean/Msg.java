package com.nju.crud.bean;

import java.util.HashMap;
import java.util.Map;

/*
* 能够返回json的通用的返回类，能够提供给浏览器如删除是否成功之类的状态信息
* */
public class Msg {
    //状态码 100表示成功 200失败
    private int code;
//  提示信息如成功失败，提示信息
    private String msg;
//  用户要返回给浏览器的数据
    private Map<String,Object> extend=new HashMap<>();

    public static Msg success(){
        Msg result=new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg fail(){
        Msg result=new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    //为了能使用add的链式操作向Msg对象中加入要返回的信息
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
