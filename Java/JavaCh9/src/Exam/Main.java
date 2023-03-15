package Exam;

public class Main {

    public static void main(String[] args) {
        Cleric cleric1 = new Cleric("아서스", 40, 5);
        Cleric cleric2 = new Cleric("아서스", 35);
        Cleric cleric3 = new Cleric("아서스");
        
        System.out.println("이름 : " + cleric1.name + ", HP : " + cleric1.HP + ", MP : " + cleric1.MP);
        System.out.println("이름 : " + cleric2.name + ", HP : " + cleric2.HP + ", MP : " + cleric2.MP);
        System.out.println("이름 : " + cleric3.name + ", HP : " + cleric3.HP + ", MP : " + cleric3.MP);
    }
}
