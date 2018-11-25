package com.baizhi.entity;

public class Category {
    private int categoryid;
    private int parentid;
    private String categoryname;
    private String categorytype;
    private int count;

    public Category() {
        super();
    }

    @Override
    public String toString() {
        return "Category{" +
                "categoryid=" + categoryid +
                ", parentid=" + parentid +
                ", categoryname='" + categoryname + '\'' +
                ", categorytype='" + categorytype + '\'' +
                ", count=" + count +
                '}';
    }

    public Category(int categoryid, int parentid, String categoryname, String categorytype, int count) {
        this.categoryid = categoryid;
        this.parentid = parentid;
        this.categoryname = categoryname;
        this.categorytype = categorytype;
        this.count = count;
    }

    public int getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(int categoryid) {
        this.categoryid = categoryid;
    }

    public int getParentid() {
        return parentid;
    }

    public void setParentid(int parentid) {
        this.parentid = parentid;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getCategorytype() {
        return categorytype;
    }

    public void setCategorytype(String categorytype) {
        this.categorytype = categorytype;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
