package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("/login")
    public String login(String email, String password, String kaptcha, HttpSession session) {
        String sessionKaptcha = (String) session.getAttribute("kaptcha");
        session.removeAttribute(kaptcha);
        if (sessionKaptcha.equalsIgnoreCase(kaptcha)) {
            User user = userService.queryOne(email, password);
            if (user != null) {
                session.setAttribute("user", user);
                return "redirect:/main/main.jsp";
            } else {
                return "index";
            }
        } else {
            return "index";
        }
    }

    @RequestMapping("exist")
    public String exist(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/index.jsp";
    }
}
