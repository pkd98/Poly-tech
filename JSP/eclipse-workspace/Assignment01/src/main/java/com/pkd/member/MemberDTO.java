package com.pkd.member;

public class MemberDTO {
    private String name;
    private String id;
    private String pw;
    private String email;
    private String gender;

    public MemberDTO(String name, String id, String pw, String email, String gender) {
        super();
        this.name = name;
        this.id = id;
        this.pw = pw;
        this.email = email;
        this.gender = gender;
    }

    public MemberDTO() {}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}

