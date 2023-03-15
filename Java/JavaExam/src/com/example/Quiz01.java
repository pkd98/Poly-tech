package com.example;

import java.util.Scanner;

public class Quiz01 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();

        System.out.print("Hello ");

        for (int i = 0; i < n; i++) {
            String name = sc.next();

            if (i == n - 1) {
                System.out.print(name + ".");
            } else {
                System.out.print(name + ",");
            }
        }
    }
}
