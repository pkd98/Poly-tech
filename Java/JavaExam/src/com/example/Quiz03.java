/*
 * 등차수열 출력하기
 */
package com.example;

import java.util.Scanner;

public class Quiz03 {

    public static String solution(int startNum, int difference) {
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < 10; i++) {
            sb.append((startNum + difference * i) + " ");
        }
        sb.deleteCharAt(sb.length() - 1);
        return sb.toString();
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int m = sc.nextInt();
        int n = sc.nextInt();
        System.out.println(solution(m, n));
    }
}