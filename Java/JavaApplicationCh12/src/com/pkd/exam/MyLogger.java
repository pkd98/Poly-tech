package com.pkd.exam;

import java.io.FileWriter;
import java.io.IOException;

// DCL(Double-Checked Locking)을 이용한 싱글턴 패턴
public class MyLogger {
    private static volatile MyLogger myLogger;
    private static FileWriter fw;

    private MyLogger() {}

    public static MyLogger getInstance() {
        if (myLogger == null) {
            synchronized (MyLogger.class) {
                if (myLogger == null) {
                    myLogger = new MyLogger();
                }
            }
        }
        try {
            fw = new FileWriter("dummylog.txt", true);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } // 파일 열기, append 모드
        return myLogger;
    }

    public void log(String message) {
        try {
            fw.write(message + "\n");
            fw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                fw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
