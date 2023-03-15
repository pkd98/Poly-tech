package Exam;

public class Wizard {
    private int hp;
    private int mp;
    private String name;
    private Wand wand;

    public int getHp() {
        return hp;
    }

    public int getMp() {
        return mp;
    }

    public String getName() {
        return name;
    }

    public Wand getWand() {
        return wand;
    }

    public void setHp(int hp) {
        if (hp < 0) {
            this.hp = 0;
        }
        this.hp = hp;
    }

    public void setMp(int mp) {
        if (mp < 0) {
            throw new IllegalArgumentException("마법사의 MP는 0 이상이어야 합니다.");
        }
        this.mp = mp;
    }

    public void setName(String name) {
        if (name == null || name.length() < 3) {
            throw new IllegalArgumentException("이름은 null 불가능, 3글자 이상");
        } else {
            this.name = name;
        }
    }

    public void setWand(Wand wand) {
        if (wand == null) {
            throw new IllegalArgumentException("완드는 null 불가능");
        }
        this.wand = wand;
    }

    public void heal(Hero hero) {
        int basePoint = 10; // 기본 회복 포인트
        int recovPoint = (int) (basePoint * this.wand.getPower()); // 지팡이에 의한 증폭
        hero.setHp(hero.getHp() + recovPoint); // 용사의 HP를 회복
    }
}
