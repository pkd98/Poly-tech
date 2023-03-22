package com.pkd.exam;

public class Counter {
    private long count = 0;
    
    public synchronized void add(long i) {
        System.out.println("더하기");
        count += i;
    }
    
    public synchronized void mul(long i) {
        System.out.println("곱하기");
        count *= i;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

}
