package com.pkd.examTest;

import static org.junit.Assert.*;
import org.junit.Test;
import com.pkd.exam.Counter;
import com.pkd.exam.DownCounter;

public class CounterTest {

    @Test
    public void counterTest() {
        Counter counter = new Counter();
        counter.setCount(10);
        counter.increase();
        counter.increase();
        assertEquals(12, counter.getCount());
    }
    @Test
    public void downCounterTest() {
        DownCounter downCounter = new DownCounter();
        downCounter.setCount(10);
        downCounter.decrease();
        downCounter.decrease();
        assertEquals(8, downCounter.getCount());
    }
}
