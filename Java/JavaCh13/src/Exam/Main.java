package Exam;

public class Main {

    public static void main(String[] args) {
        // 1. obj에서 호출할 수 있는 메소드를 a, b, c 중에 고르시오
        System.out.println("1번 문제");
        X obj = new A();
        obj.a();
        System.out.println();
        System.out.println("2번 문제");
        // 2. 화면에 표시되는 내용 확인
        Y y1 = new A();
        Y y2 = new B();
        y1.a();
        y2.a();
    }
}
