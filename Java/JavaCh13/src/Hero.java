
public class Hero {
    // field variable, global variable, member variable, property
    String name;
    int hp;
    
    public Hero(String name, int hp) {
        this.name = name;
        this.hp = hp;
        System.out.println("Hero 생성자");
    }

    void attack() {
        
    }

    void run() {}

    void sit(int sec) {}

    void slip() {}

    void sleep() {
        this.hp = 100;
        System.out.println(this.name + "는 잠을 자고 회복했다!");
    }
}
