package com.pkd.examTest;

import static org.junit.Assert.*;
import org.junit.Test;
import com.pkd.exam.UpCounter;
import com.pkd.exam.DownCounter;

public class CounterTest {

    @Test
    public void counterTest() {
        UpCounter counter = new UpCounter();
        counter.setCount(10);
        counter.count();
        counter.count();
        assertEquals(12, counter.getCount());
    }
    @Test
    public void downCounterTest() {
        DownCounter downCounter = new DownCounter();
        downCounter.setCount(10);
        downCounter.count();
        downCounter.count();
        assertEquals(8, downCounter.getCount());
    }
}
