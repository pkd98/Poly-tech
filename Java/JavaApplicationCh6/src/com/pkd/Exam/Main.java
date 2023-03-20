package com.pkd.Exam;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

public class Main {
    // 6-1
    public static String fileCopy(String fileName) throws IOException {
        String newFileName = "";

        int index = fileName.lastIndexOf(".");
        StringBuilder sb = new StringBuilder();
        sb.append(fileName.substring(0, index));
        sb.append("(복사본)");
        sb.append(fileName.substring(index));

        newFileName = sb.toString();

        FileInputStream fis = new FileInputStream(fileName);
        FileOutputStream fos = new FileOutputStream(newFileName);

        int i = fis.read();
        while (i != -1) {
            fos.write(i);
            i = fis.read();
        }
        fis.close();
        fos.close();
        return newFileName;
    }

    // 버퍼링을 통해 복사와 압축
    public static void fileBufferingGzip(String fileName, String newFileName) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(fileName));
        BufferedOutputStream bos =
                new BufferedOutputStream(new GZIPOutputStream(new FileOutputStream(newFileName)));

        String line = null;
        while ((line = br.readLine()) != null) {
            bos.write(line.getBytes());
            bos.write("\n".getBytes());
        }
        br.close();
        bos.close();
    }

    public static void main(String[] args) {
        try {
            String fileName = "data.txt";
            fileBufferingGzip(fileName, "data.zip");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
