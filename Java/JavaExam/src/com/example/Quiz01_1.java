package com.example;

import java.util.Scanner;
import java.util.Arrays;

public class Quiz01_1 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        String[] names = new String[n + 1];

        names[0] = "Hello ";
        for (int i = 1; i < n + 1; i++) {
            String input = sc.next();

            if (i == n) {
                names[i] = input + ".";
            } else {
                names[i] = input + ",";
            }
        }
        for (String name : names) {
            System.out.print(name);
        }
    }
}
