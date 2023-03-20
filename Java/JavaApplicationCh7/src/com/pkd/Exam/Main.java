package com.pkd.Exam;

import java.io.FileReader;
import java.io.Reader;
import java.util.Properties;

public class Main {

    public static void main(String[] args) {
        try (Reader fr = new FileReader("gradle.properties")) {
            Properties prop = new Properties();
            prop.load(fr);
            String data = prop.getProperty("android.useAndroidX");
            System.out.println(data);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
