import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<Hero> hero = new ArrayList<>();
        
        hero.add(new Hero("가", 0));
        hero.add(new Hero("바", 2));
        hero.add(new Hero("최", 5));
        hero.add(new Hero("이", 3));

        Collections.sort(hero);
        System.out.println(hero);
    }
}
