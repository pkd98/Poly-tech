
public class Exam6_3 {

    public static void main(String[] args) {
        
        for (int i = 0; i < 60; i++) {
            for (int j = 1; j <= 12; j++) {
                if (j == 12) {
                    System.out.printf("%d:%02d", j, i);
                } else {
                    System.out.printf("%d:%02d ", j, i);
                }
            }
            System.out.println();
        }
    }
}
