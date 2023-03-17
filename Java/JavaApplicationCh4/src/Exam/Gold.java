package Exam;

public class Gold {
    private String name;
    private int price;

    public Gold(String name, int price) {
        this.name = name;
        this.price = price;
    }

    @Override
    public String toString() {
        return "Gold [name=" + name + ", price=" + price + "]";
    }

}
