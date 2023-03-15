package com.example;

import java.util.Scanner;

public class Exam2_3 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("점을 보세요");
        System.out.println("이름을 입력해 주세요");
        String name = sc.nextLine();
        System.out.println("나이를 입력해 주세요");
        String ageString = sc.nextLine();
        int age = Integer.parseInt(ageString);

        int fortune = new java.util.Random().nextInt(4); // 0~4
        fortune++; // 1~4

        System.out.println("점꾀가 나왔습니다!");
        System.out.println(age + "살의 " + name + "씨, 당신의 운세번호는 " + fortune + " 입니다");
        System.out.println("1:대박 2:중박 3:보통 4:망");
    }
}
