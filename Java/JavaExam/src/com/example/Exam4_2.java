package com.example;

public class Exam4_2 {
    public static void main(String[] args) {
        int[] moneyList = {121902, 8302, 55100};

        // 일반 for문을 통한 배열 요소 가져오기
        for (int i = 0; i < moneyList.length; i++) {
            System.out.println(moneyList[i]);
        }
        // for - each 문을 통한 배열 요소 가져오기
        for (int money : moneyList) {
            System.out.println(money);
        }
    }
}
