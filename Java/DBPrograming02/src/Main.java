public class Main {
    public static void main(String[] args) {
        // 시간 측정 시작
        long startTime = System.currentTimeMillis();
        
        // DB 프로그램 시작
        Repository repo = new Repository();
        
        // 시간 측정 종료
        long endTime = System.currentTimeMillis();
        
        // 측정된 시간 출력
        System.out.println("프로그램 시간 측정: " + (double) (endTime - startTime) / 1000.0 + "초");
    }
}
