import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Main2 {
    
    // '박'씨 가져오기 - stream을 활용한 lambda 식 표현
    public static List<String> getParkListStream(List<String> names) {
        return names.stream().filter(name -> name.startsWith("박")).collect(Collectors.toList());
    }
    
    // '박'씨 가져오기 - 기존 for문을 활용한 표현
    public static List<String> getParkList(List<String> names) {
        List<String> results = new ArrayList<>();

        for (String name : names) {
            if (name.startsWith("박")) {
                results.add(name);
            }
        }
        return results;
    }

    
    
    public static void main(String[] args) {
        // 스트림 실습
        List<Integer> nums = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 5, 6));

        // 일반적인 for문을 통한 짝수 출력
        for (int i = 0; i < nums.size(); i++) {
            if (nums.get(i) % 2 == 0) {
                System.out.println(nums.get(i));
            }
        }
        
        // 스트림을 활용한 출력
        nums.stream().forEach((num) -> {
            System.out.println(num); // 입력이 Integer이고, 리턴이 void
        });

        // 위 코드 축약
        nums.stream().forEach(num -> System.out.println(num));

        // 한번 더 축약
        nums.stream().forEach(System.out::println);

        // 필터 사용 - 주어진 조건에 매치되는 것만 출력하는 법
        nums.stream().filter((Integer num) -> num % 2 == 0) // 짝수만 남게 하기
                .map((num) -> num + "번") // 변환할 때 map 사용 (<T>) -> (<R>)
                // Map을 사용하면 List의 타입을 변화시킬 수 있다.
                .forEach((num) -> System.out.println(num + 1));
        
        // 모든 리턴 타입은 stream()이다 그렇기에 한줄 코딩으로 .() 할 수 있는 것이다.
        // -> 메서드 체이닝
        // forEach는 맨 마지막에만 올 수 있다.

//        // 기존 for문을 사용한 표현


        List<String> names = new ArrayList<>();
        names.add("박1");
        names.add("박2");
        names.add("이1");
        names.add("김1");
        names.add("박3");
        
        List<String> parks = getParkList(names);
        List<String> parks2 = getParkListStream(names);
        System.out.println(parks);
        System.out.println(parks2);
    }
}
