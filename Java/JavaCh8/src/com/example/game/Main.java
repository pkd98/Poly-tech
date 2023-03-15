package com.example.game;

public class Main {

    public static void main(String[] args) {
        int i = 10;
        
        // 용사 생성
        Hero hero = new Hero();
        
        // 생성된 용사에게 최초 HP, 이름 설정
        hero.name = "PKD";
        hero.hp = 100;
        System.out.println("용사 " + hero.name + " 를 생성했습니다!");
        System.out.println(hero.name + " : " + hero.hp);
        
        // 용사에게 '5 초 앉기', '넘어지기', '25초 앉기', '도망' 지시
        hero.sit(5);
        hero.slip();
        hero.sit(25);
        hero.run();
        
        // 버섯 괴물 생성
        Kinoko kinoko1 = new Kinoko();
        kinoko1.hp = 50;
        kinoko1.suffix = 'A';
        
        Kinoko kinoko2 = new Kinoko();
        kinoko1.hp = 50;
        kinoko1.suffix = 'B';

    }

}
