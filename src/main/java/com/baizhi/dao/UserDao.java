package com.baizhi.dao;

import com.baizhi.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserDao {
    public User queryOne(@Param("email") String email, @Param("password") String password);
}
