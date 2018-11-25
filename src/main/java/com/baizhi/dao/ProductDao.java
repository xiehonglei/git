package com.baizhi.dao;

import com.baizhi.entity.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductDao {
    public List<Product> queryAll(@Param("start") int start, @Param("pagesize") int pagesize);

    public int getCount();

    public void deleteMany(int[] ids);

    public void add(Product product);

    public void update(Product product);
}
