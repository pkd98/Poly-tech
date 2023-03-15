package com.example;

public class Exam5_4 {

    public static double calcTriangleArea(double bottom, double height) {
        // 소수 점 둘째 자리 반올림
        return Math.round((bottom * height * 0.5) * 100) / 100.0;
    }

    public static double calcCircleArea(double radius) {
        // 소수 점 둘째 자리 반올림
        return Math.round((Math.PI * Math.pow(radius, 2.0)) * 100) / 100.0;
    }

    public static void main(String[] args) {
        System.out.println(calcTriangleArea(4, 2));
        System.out.println(calcCircleArea(5));
    }
}