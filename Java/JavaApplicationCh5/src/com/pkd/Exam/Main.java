package com.pkd.Exam;

public class Main {

    public static void main(String[] args) {
        Func1 func1 = num -> num % 2 == 1;
        
        Func2 func2 = (male, name) -> {
            if (male == true) {
                return "Mr." + name;
            }
            return "Ms." + name;
        };
    }
}
