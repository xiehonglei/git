package com.baizhi.controller;

import com.baizhi.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/products")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @RequestMapping("getCategory")
    public @ResponseBody
    Map getCategory() {
        return categoryService.getCategory();
    }
}
