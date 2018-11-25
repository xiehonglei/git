package com.baizhi.entity;

import java.util.Date;

public class User {
    private int id;
    private String email;
    private String nickname;
    private String password;
    private Date create_date;
    private String state;
    private String authority;

    public User() {
        super();
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", nickname='" + nickname + '\'' +
                ", password='" + password + '\'' +
                ", create_date=" + create_date +
                ", state='" + state + '\'' +
                ", authority='" + authority + '\'' +
                '}';
    }

    public User(int id, String email, String nickname, String password, Date create_date, String state, String authority) {
        this.id = id;
        this.email = email;
        this.nickname = nickname;
        this.password = password;
        this.create_date = create_date;
        this.state = state;
        this.authority = authority;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getAuthority() {
        return authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }
}
