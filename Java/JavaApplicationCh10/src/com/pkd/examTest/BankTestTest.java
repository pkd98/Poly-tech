package com.pkd.examTest;

import static org.junit.Assert.assertEquals;
import org.junit.Test;
import com.pkd.exam.Bank;

public class BankTestTest {

    // 이름 4글자 이상 정상 테스트
    @Test
    public void 정상test() {
        Bank bank = new Bank();
        bank.setName("하나은행");
        assertEquals("하나은행", bank.getName());

    }

    // 이름 3글자 이하 예외가 발생해야 하는 경우 테스트
    @Test(expected = IllegalArgumentException.class)
    public void 예외test() {
        Bank bank = new Bank();
        bank.setName("하나");
    }
}
