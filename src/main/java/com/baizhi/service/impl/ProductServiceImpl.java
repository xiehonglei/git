package com.baizhi.service.impl;

import com.baizhi.dao.ProductDao;
import com.baizhi.entity.Product;
import com.baizhi.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;

    @Override
    public Map queryAll(int page, int rows) {
        //获取当前页数据
        int start = (page - 1) * rows + 1;
        int total = productDao.getCount();
        int pagesize = rows;
        Map map = new HashMap();
        List<Product> list = productDao.queryAll(start, pagesize);
        map.put("total", total);
        map.put("rows", list);
        return map;
    }

    @Override
    public void deleteMany(int[] ids) {
        productDao.deleteMany(ids);
    }

    @Override
    public void add(Product product) {
        productDao.add(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }
}
