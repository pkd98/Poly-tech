package com.pkd.Exam;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class Main {

    public static void fileCopy(String file) throws IOException {
        int index = file.lastIndexOf(".");
        StringBuilder sb = new StringBuilder();
        sb.append(file.substring(0, index));
        sb.append("(복사본)");
        sb.append(file.substring(index));
        
        FileInputStream fis = new FileInputStream(file);
        FileOutputStream fos = new FileOutputStream(sb.toString());

        int i = fis.read();
        while (i != -1) {
            fos.write(i);
            i = fis.read();
        }
        fis.close();
        fos.close();
    }

    public static void main(String[] args) {
        try {
            fileCopy("data.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
