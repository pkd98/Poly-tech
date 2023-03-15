package com.example.Exam;

public class Main {

    public static void main(String[] args) {
        Cleric cleric = new Cleric();
        
        System.out.println("초기 MP : " + cleric.MP);
        cleric.selfAid();
        System.out.println("selfAid 발동 후 MP : " + cleric.MP);
        System.out.println("----------------------------------");
        System.out.println("pary 3초 발동");
        System.out.println("실제 회복량 : " + cleric.pray(3));
        System.out.println("발동 후 MP : " + cleric.MP);
    }
}
