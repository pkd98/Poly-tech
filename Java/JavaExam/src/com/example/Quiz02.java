/*
 * 홀수 짝수 쌍 판별
 */
package com.example;

import java.util.Scanner;

public class Quiz02 {
    // 홀수 판별
    public static boolean isOdd(int num) {
        return (num % 2 == 0) ? true : false;
    }

    // 홀수 판변 후 같은지 비교
    public static String solution(int n, int m) {
        boolean nIsOdd = isOdd(n);
        boolean mIsOdd = isOdd(m);

        return nIsOdd == mIsOdd ? "YES" : "NO";
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int N = sc.nextInt();
        int M = sc.nextInt();

        System.out.println(solution(N, M));
    }
}
