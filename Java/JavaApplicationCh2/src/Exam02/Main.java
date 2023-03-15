package Exam02;

import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {
        Person person1 = new Person();
        person1.name = "홍길동";
        
        Person person2 = new Person();
        person2.name = "한석봉";
        
        ArrayList <Person> personList = new ArrayList<>();
        personList.add(person1);
        personList.add(person2);
        
        for(Person person : personList) {
            System.out.println(person.name);
        }
    }
}
