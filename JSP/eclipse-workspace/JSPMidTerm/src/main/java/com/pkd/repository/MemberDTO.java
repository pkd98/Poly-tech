package com.pkd.repository;

public class MemberDTO {

    private String id;
    private String pw;
    private String name;
    private String phone;
    private String email;
    private String status;
    private String role;
    private String withdraw;

    public MemberDTO(String id, String pw, String name, String phone, String email, String status, String role, String withdraw) {
        super();
        this.id = id;
        this.pw = pw;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.status = status;
        this.role = role;
        this.withdraw = withdraw;
    }
    
    public MemberDTO() {}

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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    

    public String getWithdraw() {
        return withdraw;
    }

    public void setWithdraw(String withdraw) {
        this.withdraw = withdraw;
    }

    @Override
    public String toString() {
        return "MemberDTO [id=" + id + ", pw=" + pw + ", name=" + name + ", phone=" + phone
                + ", email=" + email + ", status=" + status + ", role=" + role + "]";
    }
    
    
}
