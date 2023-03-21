package com.pkd.Exam;

public class Utils {
    public static boolean isOdd(int n) {
        return n % 2 == 1;
    }

    public static String addNamePrefix(boolean male, String name) {
        if (male == true) {
            return "Mr." + name;
        }
        return "Ms." + name;
    }
}
