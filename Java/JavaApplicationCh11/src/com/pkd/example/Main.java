package com.pkd.example;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
//        // 메인 스레드 확인
//        System.out.println("Thread :" + Thread.currentThread().getName());
//
//        // Runnable 구현한 클래스를 인자로 주어 스레드 사용
//        Thread thread = new Thread(new PrintingThread());
//        thread.start();
//        
//         // 다른 스레드 확인
//         new Thread(() -> {
//         System.out.println("Thread :" + Thread.currentThread().getName());
//         }).start();;
//        
//        
//         // 무명 클래스를 활용한 스레드 구현
//         new Thread(new Runnable() {
//         @Override
//         public void run() {}
//         }).start();
//        
//        
//         // 람다식을 이용한 스레드 구현
//         new Thread(() -> {
//        
//         }).start();
//        

        StringBuffer sb = new StringBuffer();
        
        new Thread(() -> {
            for (int i = 0; i < 5; i++)
                try {
                    Thread.sleep(100);
                    System.out.println("Thread :" + Thread.currentThread().getName() + " " + i);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
        }).start();


        new Thread(() -> {
            for (int i = 0; i < 5; i++)
                try {
                    Thread.sleep(100);
                    System.out.println("Thread :" + Thread.currentThread().getName() + " " + i);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
        }).start();
    }
}
