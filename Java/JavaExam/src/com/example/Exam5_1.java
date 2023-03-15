package com.example;

public class Exam5_1 {

    public static void introduceOneself() {
        String name = "박경덕";
        int age = 26;
        char gender = '남';

        System.out.printf("안녕하세요. %s입니다. 저는 %d살 %c자입니다.\n", name, age, gender);
    }

    public static void main(String[] args) {
        introduceOneself();
    }
}
