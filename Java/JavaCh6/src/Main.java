import java.util.Arrays;

public class Main {

    public static void main(String[] args) {
        int a = 10;
        int b = 2;
        int total = add(a, b);
        int delta = minus(a, b);
        System.out.println("더하면 " + total + ", 빼면 " + delta);
    }
    
    private static int add(int a, int b) {
        return a + b;
    }
    
    private static int minus(int a, int b) {
        return a - b;
    }
}
