package Exam;

public class Main {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        Book book = new Book("이펙티브 자바 3/E", 30000, "green", "A123");
        Computer computer = new Computer("gram", 1500000, "Black", "LG");
        book.setWeight(150.0);
        computer.setWeight(980.5);

        System.out.println(computer.getName() + " : " + computer.getPrice() + " "
                + computer.getColor() + " " + computer.getMakerName() + " " + computer.getWeight());
        System.out.println(book.getName() + " : " + book.getPrice() + " " + book.getColor() + " "
                + book.getIsbn() + " " + book.getWeight());
    }

}
