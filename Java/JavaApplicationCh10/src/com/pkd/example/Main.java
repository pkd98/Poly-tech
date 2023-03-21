package com.pkd.example;
public class Main {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        System.out.println("--- 테스트 시작 ---");
        Account account = new Account("홍길동", 30000);
        System.out.println(account);
        
        Account account2 = new Account("한석봉", 0);
        account.transfer(account2, Integer.MAX_VALUE + 1);
        
        if (account2.getBalance() != 2147483648L) {
            System.out.println("getBalance() 값 다름 " + account2.getBalance());
        }
        
        System.out.println("--- 테스트  끝  ---");
    }
}
