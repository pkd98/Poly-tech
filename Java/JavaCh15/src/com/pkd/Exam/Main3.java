package com.pkd.Exam;

public class Main3 {

    public static void main(String[] args) {
        String s = "Tree";
        try {
            int i = Integer.parseInt(s);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
