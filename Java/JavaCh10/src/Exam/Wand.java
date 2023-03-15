package Exam;

public class Wand {
    private String name; // 지팡이 이름
    private double power; // 지팡이 마력

    public double getPower() {
        return power;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name == null || name.length() < 3) {
            throw new IllegalArgumentException("이름은 null 불가능, 3글자 이상");
        } else {
            this.name = name;
        }
    }

    public void setPower(double power) {
        if (0.5 <= power && power <= 100.0) {
            this.power = power;
        } else {
            throw new IllegalArgumentException("마력은 0.5 이상 100.0 이하만 가능");
        }
    }
}
