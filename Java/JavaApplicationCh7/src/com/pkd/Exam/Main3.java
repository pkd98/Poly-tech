package com.pkd.Exam;

import java.io.FileInputStream;
import java.io.ObjectInputStream;

public class Main3 {

    public static void main(String[] args) {
        try (FileInputStream fis = new FileInputStream("company.dat")) {
            ObjectInputStream ois = new ObjectInputStream(fis);
            Department department = (Department) ois.readObject();
            System.out.println(department);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
