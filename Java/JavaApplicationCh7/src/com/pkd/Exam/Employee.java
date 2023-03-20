package com.pkd.Exam;

import java.io.Serializable;

public class Employee implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    String name;
    int age;

    @Override
    public String toString() {
        return "Employee [name=" + name + ", age=" + age + "]";
    }
}
