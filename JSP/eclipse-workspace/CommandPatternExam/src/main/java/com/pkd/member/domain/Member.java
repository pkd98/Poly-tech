package com.pkd.member.domain;

public class Member {
    String id;
    String pw;
    String name;
    
    public Member(String id, String pw, String name) {
        super();
        this.id = id;
        this.pw = pw;
        this.name = name;
    }
    
    public Member() {}
    
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPw() {
        return pw;
    }
    public void setPw(String pw) {
        this.pw = pw;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Member [id=" + id + ", pw=" + pw + ", name=" + name + "]";
    }
}
