package Exam;

public class Main {

    public static void main(String[] args) {
        Wizard wizard = new Wizard();
        Wand wand = new Wand();

        wand.setName("나무 지팡이");
        wand.setPower(10.5);

        wizard.setHp(50);
        wizard.setMp(10);
        wizard.setName("해리포터");
        wizard.setWand(wand);

        System.out.println("캐릭터이름 : " + wizard.getName() + ", HP: " + wizard.getHp() + ", MP: "
                + wizard.getMp());
        System.out.println(
                "장착한 완드: " + wizard.getWand().getName() + ", 파워 : " + wizard.getWand().getPower());
    }
}
