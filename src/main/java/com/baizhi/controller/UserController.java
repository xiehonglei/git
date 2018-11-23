package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;
    @RequestMapping("/queryAll")
    public String queryall(){
        List<User> list=userService.queryAll();
        for (int i = 0; i < list.size(); i++) {
            User user =  list.get(i);
            System.out.println(user);
        }
        return "index";
    }
}
