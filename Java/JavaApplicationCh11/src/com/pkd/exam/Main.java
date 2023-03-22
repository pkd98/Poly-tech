package com.pkd.exam;

public class Main {

    // public static void main(String[] args) {
    // for(int i = 0; i < 3; i++) {
    // new Thread(() -> {
    // CountUpThread cut = new CountUpThread();
    // }).start();
    // }
    // }

    public static void main(String[] args) throws InterruptedException {
        Counter counter = new Counter();
        for (int i = 0; i < 3; i++) {
            new Thread(() -> {
                counter.add(1);
                counter.add(1);
                counter.mul(2);
                counter.mul(2);
            }).start();
        }
        Thread.sleep(10);
        System.out.println(counter.getCount());
    }
}
