package Exam;

public class Main {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        Kinoko kinoko = new Kinoko('A');
        PoisonKinoko poisonKinoko = new PoisonKinoko('B');
        Hero hero = new Hero("용사1", 100);
        
        poisonKinoko.attack(hero);
        System.out.println(hero.getName() + "의 HP: " + hero.getHp());
        System.out.println("-------------------------------------------");
        poisonKinoko.attack(hero);
        System.out.println(hero.getName() + "의 HP: " + hero.getHp());
        System.out.println("-------------------------------------------");
        poisonKinoko.attack(hero);
        System.out.println(hero.getName() + "의 HP: " + hero.getHp());
        System.out.println("-------------------------------------------");
        poisonKinoko.attack(hero);
        System.out.println(hero.getName() + "의 HP: " + hero.getHp());
        System.out.println("-------------------------------------------");
        poisonKinoko.attack(hero);
        System.out.println(hero.getName() + "의 HP: " + hero.getHp());
        System.out.println("-------------------------------------------");
        poisonKinoko.attack(hero);
        System.out.println(hero.getName() + "의 HP: " + hero.getHp());

    }
}
