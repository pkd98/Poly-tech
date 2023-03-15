package com.example;

public class Exam4_4 {
    public static void main(String[] args) {
        int[] numbers = {3, 4, 9};
        System.out.println("1자리의 숫자를 입력 해 주세요");
        int input = new java.util.Scanner(System.in).nextInt();

        for (int number : numbers) {
            if (number == input) {
                System.out.println("정답!");
                break;
            }
        }
    }
}
