import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

interface MyFuction {
    int call(int a, int b);
}

public class Main {
    
    public static void main(String[] args) {
        // 스트림 실습
        List<Integer> nums = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 5, 6));
        
        // 일반적인 for문을 통한 출력
        
        // 스트림을 활용한 출력
        nums.stream().forEach((num) -> {
            System.out.println(num); //입력이 Integer이고, 리턴이 void
        });
        
        // 위 코드 축약
        nums.stream().forEach(num -> System.out.println(num));
        
        // 한번 더 축약
        nums.stream().forEach(System.out::println);
        
        // 필터 사용 - 주어진 조건에 매치되는 것만 출력하는 법
        nums.stream()
            .filter((Integer num) -> num % 2 == 0) // 짝수만 남게 하기
            .forEach(System.out::println);
    }
    
        
    public static int add(int x, int y) {
        return x + y;
    }

    public static int multiply(int x, int y) {
        return x * y;
    }

    public static int 더하기(int a, int b) {
        return a + b;
    }

}
