package com.example.main;

import com.example.logics.CalcLogic;

public class Main {

    public static void main(String[] args) {
        int a = 10;
        int b = 20;
        int total = CalcLogic.add(a, b);
        int delta = CalcLogic.minus(a, b);
        System.out.println("더하면 " + total + ", 빼면 " + delta);
    }

}
