import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        List list = new ArrayList<>();

        list.add(1);
        list.add("홍길동");
        list.add(null);
        list.add(3.0);
        list.add(true);

        System.out.println(list);
        System.out.println((String) list.get(0) + 10);
        }
}
