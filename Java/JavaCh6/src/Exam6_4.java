import java.util.Random;
import java.util.Scanner;

public class Exam6_4 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random random = new Random();
        System.out.println("던질 횟수를 입력해주세요");
        long tries = sc.nextLong();
        int hits = 0;

        for (int i = 0; i < tries; i++) {
            // -1.0 ~ +1.0 난수 생성
            double x = random.nextDouble() * 2 - 1;
            double y = random.nextDouble() * 2 - 1;
            if (Math.sqrt(x * x + y * y) <= 1) {
                hits++;
            }
        }

        double piEstimate = 4 * hits / (double) tries;
        System.out.println(piEstimate);
    }
}
