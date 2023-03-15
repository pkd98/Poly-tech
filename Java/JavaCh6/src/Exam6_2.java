
public class Exam6_2 {

    public static void main(String[] args) {

        for (int i = 1; i < 10; i++) {
            for (int j = 2; j < 10; j++) {
                if (j == 9) {
                    System.out.printf("%d * %d = %2d", j, i, j * i);
                } else {
                    System.out.printf("%d * %d = %2d \t", j, i, j * i);
                }
            }
            System.out.println();
        }
    }
}
