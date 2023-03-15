
public class SuperHero extends Hero {
    private boolean flying;
    
    public SuperHero() {
        System.out.println("SuperHero 생성자");
    }
    
    
    
    
    public void fly() {
        flying = true;
        System.out.println("날았다!");
    }
    
    public void land() {
        flying = false;
        System.out.println("착지");
    }
    
    @Override
    public void run() {
        System.out.println("퇴각");
    }
    
    @Override
    void attack() {
        System.out.println("준비");
        
        super.attack(); // 상속 상위 코드 실행
        
        if(flying) {
            System.out.println("추가 공격");
        }
    }
    
}
