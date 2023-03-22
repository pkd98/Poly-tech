package com.pkd.example;

public class Counter {
    int num = 0;

    public static void main(String[] args) throws Exception {
        Counter counter = new Counter();
//        // 1. 동기화를 하지 않았을 경우.
//        for (int i = 0; i < 1000; i++) {
//            new Thread(() -> {
//                 try {
//                    Thread.sleep(10);
//                } catch (InterruptedException e) {
//                    e.printStackTrace();
//                }
//                counter.num++; // 스레드 내에서 다른 객체를 조작하면
//            }).start();
//        }
//        Thread.sleep(2000);
//        System.out.println(counter.num);
        
        // 2. 동기화 했을 경우
        Counter counter2 = new Counter();
        for (int i = 0; i < 1000; i++) {
            new Thread(() -> {
                try {
                    Thread.sleep(10);
                    synchronized (counter2) {
                        counter2.num++; // 스레드 내에서 다른 객체를 조작하면
                    }
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }).start();
        }
        Thread.sleep(2000);
        System.out.println(counter2.num);
    }
}
