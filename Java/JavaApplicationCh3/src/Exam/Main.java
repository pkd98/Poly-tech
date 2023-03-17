package Exam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Main {

    public static void main(String[] args) {
        Date date1 = new Date(1111111111111L);
        Date date2 = new Date(1222222222222L);
        Date date3 = new Date(1223333333333L);
        Date date4 = new Date(1224444444444L);
        Date date5 = new Date(1225555555555L);
        
        Book javaBook1 = new Book("자바 책", date1, "좋은 책"); // 책이름과 출판일이 같음
        Book javaBook2 = new Book("자바 책", date1, "조아용");  // 책이름과 출반일이 같음
        Book javaBook3 = new Book("자바 책", date2, "좋은 책"); // 출판일이 다름
        Book dbBook = new Book("DB 책", date4, "보통 책");
        Book pythonBook = new Book("파이썬 책", date3, "좋아요");
        Book kotlinBook = new Book("코틀린 책", date2, "많이 사세요");
        Book cppBook = new Book("C++ 책", date5, "어려워요");

        // 1. 제목과 출간일 같으면 같은 책으로 판단 확인
        Set<Book> bookSet = new HashSet<Book>();
        bookSet.add(javaBook1);
        bookSet.add(javaBook2);
        System.out.println(bookSet.size());
        bookSet.add(javaBook3);
        System.out.println(bookSet.size()); // 출판일이 다를 경우에는 다른 책으로 인식
        
        // 2. Book 인스턴스 담은 컬렉션에 대해 Collections.sort() - 출간일이 오래된 순서대로 정렬
        List<Book> bookList = new ArrayList<Book>();
        bookList.add(javaBook1);
        bookList.add(dbBook);
        bookList.add(pythonBook);
        bookList.add(kotlinBook);
        bookList.add(cppBook);
        System.out.println("정렬 전" + bookList);
        Collections.sort(bookList);
        System.out.println("정렬 후" + bookList); // 출간일이 오래된 순서대로 정렬되었다.
        
        Book cppBook2 = cppBook.clone();
        cppBook2.setTitle("수정cpp2");
        System.out.println(cppBook);
        System.out.println(cppBook2); // 깊은 복사가 되었다.
    }
}
