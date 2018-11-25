package com.baizhi.service;

import com.baizhi.entity.Product;

import java.util.Map;

public interface ProductService {
    public Map queryAll(int page, int rows);

    public void deleteMany(int[] ids);

    public void add(Product product);

    public void update(Product product);
}
