import java.util.function.IntBinaryOperator;

public class Main0 {
    public static int add123(int x, int y) {
        return x + y;
    }

    public static void main(String[] args) {
        IntBinaryOperator func = Main::add;
        
        int result = func.applyAsInt(5, 3);
        System.out.println("5 + 3 = " + result);
    }
}
