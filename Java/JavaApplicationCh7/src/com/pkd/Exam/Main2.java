package com.pkd.Exam;

import java.io.FileOutputStream;
import java.io.ObjectOutputStream;

public class Main2 {

    public static void main(String[] args) {
        Employee employee = new Employee();
        employee.name = "홍길동";
        employee.age = 41;

        Department department = new Department();
        department.name = "총무부";
        department.leader = employee;
        try (FileOutputStream fos = new FileOutputStream("company.dat")) {
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(department);
            oos.flush();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
