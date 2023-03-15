package Exam;

public class PoisonKinoko extends Kinoko{
    private int poisonCount;
    
    public PoisonKinoko(char suffix) {
        super(suffix);
        poisonCount = 5;
    }
    
    @Override
    void attack(Hero hero) {
        super.attack(hero);
        if(poisonCount > 0) {
            System.out.println("추가로, 독 포자를 살포했다!");
            int damage = (int) (hero.getHp() * 0.2);
            hero.setHp(hero.getHp() - damage);
            System.out.println(damage + "포인트의 데미지");
            poisonCount--;
        } else {
            System.out.println("독을 쓰진 못했다.");
        }
    }
}
