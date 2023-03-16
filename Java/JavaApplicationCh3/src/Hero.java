import java.util.Objects;

public class Hero implements Comparable<Hero>{
    // field variable, global variable, member variable, property
    String name;
    int hp;
    
    Hero(String name, int hp){
        this.name = name;
        this.hp = hp;
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(hp, name);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Hero other = (Hero) obj;
        return hp == other.hp && Objects.equals(name, other.name);
    }

    @Override
    public String toString() {
        return "Hero [name=" + name + ", hp=" + hp + "]";
    }

    @Override
    public int compareTo(Hero o) {
        return this.name.compareTo(o.name); // 미리 String에 구현된 compareTo()를 이용
    }
    
//    @Override
//    public int compareTo(Hero o) {
//        if (this.hp < o.hp) {
//            return -1;
//        }
//        if (this.hp > o.hp) {
//            return 1;
//        }
//        return 0;
//    }

}

