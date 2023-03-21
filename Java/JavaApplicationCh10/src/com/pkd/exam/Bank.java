package com.pkd.exam;

public class Bank {
    private String name;
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        if (name.length() <= 3) {
            throw new IllegalArgumentException("이름이 잘못 되었음");
        }
        this.name = name;
    }
}
