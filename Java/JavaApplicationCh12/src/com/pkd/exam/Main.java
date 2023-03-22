package com.pkd.exam;

public class Main {
    
    public static void main(String[] args) {
        // 인스턴스화 동시에 dummylog.txt 파일 열기
        // logger 인스턴스를 얻기
        MyLogger logger1 = MyLogger.getInstance();
        logger1.log("first");
        
        MyLogger logger2 = MyLogger.getInstance();
        logger2.log("second");
    }
}
