import java.util.Scanner;

/*
 * 조용한 곳 찾기
 * 
 * 공사 현장 좌표 (a, b) 반경 R 미터 미만 소음이 크다.
 * 
 * 공원에 그늘 N개, i 번째 그늘 위치 (x_i, y_i)
 * 
 * 해당 각 그늘이 독서에 적합한지 여부 구해라! (x - a)^2 + (y - b)^2 >= R^2
 */

public class Assignment1 {
    
    public static String determine(int a, int b, int x, int y, int R) {
        String answer = "";
        
        if (((x - a) * (x - a) + (y - b) * (y - b)) >= R * R) {
            answer = "silent";
        } else {
            answer = "noisy";
        }
        
        return answer;
    }
    
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int a = sc.nextInt(); // 공사현장 x좌표
        int b = sc.nextInt(); // 공사현장 y좌표
        int R = sc.nextInt(); // 공사장 소음의 크기
        int N = sc.nextInt(); // 그늘 개수
        
        for (int i = 0; i < N; i++) {
            int x = sc.nextInt();
            int y = sc.nextInt();
            System.out.println(determine(a, b, x, y, R));
        }
    }
}
