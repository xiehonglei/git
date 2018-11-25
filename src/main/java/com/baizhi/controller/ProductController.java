package com.baizhi.controller;

import com.baizhi.entity.Product;
import com.baizhi.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/products")
public class ProductController {
    @Autowired
    private ProductService productService;

    @RequestMapping("/queryAllProduct")
    public @ResponseBody
    Map queryAllProduct(int page, int rows) {
        return productService.queryAll(page, rows);
    }

    @RequestMapping("/deleteMany")
    public @ResponseBody
    boolean deleteMany(int[] ids) {
        try {
            productService.deleteMany(ids);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @RequestMapping("/add")
    public @ResponseBody
    boolean add(Product product, MultipartFile myjar, HttpServletRequest request) {
        try {
            String fileName = myjar.getOriginalFilename();
            fileName = new Date().getTime() + "_" + fileName;
            product.setProduct_image(fileName);
            String realPath = request.getRealPath("/productImages/");
            myjar.transferTo(new File(realPath + "\\" + fileName));
            productService.add(product);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @RequestMapping("/update")
    public @ResponseBody
    boolean update(Product product, MultipartFile myjar, HttpServletRequest request) {
        System.out.println(product + "----------------------------------------------------------------------");
        try {
            if (!"".equals(myjar.getOriginalFilename())) {
                String realPath = request.getRealPath("/productImages/");
                File file = new File(realPath + "\\" + product.getProduct_image());
                file.delete();

                String fileName = myjar.getOriginalFilename();
                //���ļ�����������
                fileName = new Date().getTime() + "_" + fileName;

                product.setProduct_image(fileName);
                myjar.transferTo(new File(realPath + "\\" + fileName));
            }

            productService.update(product);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

}
