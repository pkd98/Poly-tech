package com.pkd.Exam;

import java.io.Serializable;

public class Department implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    String name;
    Employee leader;
    @Override
    public String toString() {
        return "Department [name=" + name + ", leader=" + leader + "]";
    }
}
