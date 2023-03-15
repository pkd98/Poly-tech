import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        Hero hero = new Hero();
        hero.name = "홍길동";
        
        List<Hero> heroList = new ArrayList<>();
        heroList.add(hero);
        hero.name = "한석봉";
        
        System.out.println(heroList.get(0).name);
    }

}
