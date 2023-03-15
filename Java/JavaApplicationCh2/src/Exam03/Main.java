package Exam03;

import java.util.HashMap;

public class Main {

    public static void main(String[] args) {
        Person person1 = new Person();
        person1.name = "홍길동";
        person1.age = 20;
        
        Person person2 = new Person();
        person2.name = "한석봉";
        person2.age = 25;
        
        HashMap<String, Integer> personHashMap = new HashMap<String, Integer>();
        personHashMap.put(person1.name, person1.age);
        personHashMap.put(person2.name, person2.age);
       
        for(String key : personHashMap.keySet()) {
            int age = personHashMap.get(key);
            System.out.println(key + "의 나이는 " + age + "살");            
        }
    }
}
