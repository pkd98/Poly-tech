import java.io.FileWriter;
import java.io.IOException;

public class Main {

    public static void main(String[] args) {
        try (FileWriter fw = new FileWriter("data.txt");) {
            something();
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    

}

    public static void something() throws InterruptedException {
        System.out.println("시작");
        Thread.sleep(1000);
        System.out.println("끝");
    }
}

