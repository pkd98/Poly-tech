package com.pkd.exam;

public class DownCounter {
    private int count = 0;
    
    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public void decrease() {
        count--;
    }
}
