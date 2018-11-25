package com.baizhi.service;

import com.baizhi.entity.User;

public interface UserService {
    public User queryOne(String email, String password);
}
