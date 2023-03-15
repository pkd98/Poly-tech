package Exam;

import java.util.Random;

public class Cleric {
    String name;
    int HP;
    int MP;
    static final int MAX_HP = 50;
    static final int MAX_MP = 10;
    Random random = new Random();

    public Cleric(String name, int HP, int MP) {
        this.name = name;
        this.HP = HP;
        this.MP = MP;
    }
    
    public Cleric(String name, int HP){
        this(name, HP, MAX_MP);
    }
    
    public Cleric(String name){
        this(name, MAX_HP, MAX_MP);
    }

    void selfAid() {
        if (this.MP >= 5) {
            this.MP = MP - 5;
            this.HP = MAX_HP;
        }
    }

    int pray(int sec) {
        int realAmount = 0;

        int oldMP = this.MP;
        int amount = (random.nextInt(3) + sec);
        this.MP = (this.MP + amount) <= MAX_MP ? (this.MP + amount) : MAX_MP;
        realAmount = this.MP - oldMP;

        return realAmount;
    }
}
