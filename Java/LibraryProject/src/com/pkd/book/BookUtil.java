package com.pkd.book;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import com.pkd.utils.Utils;

public class BookUtil {

    static List<Book> bookList = new ArrayList<>(); // 도서 목록
    static List<Book> bookStack = new ArrayList<>(1); // 삭제 취소를 위한 stack

    public BookUtil() {}

    public static void bookRegister(Book book) { // 도서 등록
        int beforeSize = bookList.size();
        bookList.add(book);
        if (bookList.size() == beforeSize) {
            System.out.println("도서 등록 실패!");
        } else {
            System.out.println("정상 등록 되었습니다.");
        }

        // 사용자 모드( 파일 입출력 추가 )

        // --------------------------------
    }

    public static void bookModify(int modifyBookId, String newBookName, Date newReleaseDate) { // 도서
        boolean checkId = false;
        for (Book book : bookList) {
            if (modifyBookId == book.getBookId()) {
                book.setName(newBookName);
                book.setReleaseDate(newReleaseDate);
                checkId = true;
            }
        }
        if (checkId == true)
            System.out.println("수정되었습니다.");
        else
            System.out.println("잘못된 ID입니다.");
    }

    public static void bookRemove(int ID) { // 도서 삭제
        boolean check = false;
        // ID 같은 값을 제거
        for (Book book : bookList) {
            if (book.getBookId() == ID) {
                bookStack.add(book); // 삭제 undo 기능을 위해 스택에 저장
                bookList.remove(book);
                check = true;
                break;
            }
        }
        
        if (check == true)
            System.out.println("정상 삭제 되었습니다.");
        else
            System.out.println("잘못된 입력 입니다.");
    }

    public static void bookRent() { // 도서 대출

        // 어떤 도서
        
        // 어떤 회원이 대출했는지 선택

        // 도서 rent 상태 true 처리

        // 대출 정보 클래스


    }

    public static void bookReturn() { // 도서 반납

    }
    
    public static void bookUndo() {
        if (bookStack.size() == 0) {
            System.out.println("삭제 취소할 책이 없습니다.");
        }
        else {
            bookList.add(bookStack.get(0));
            bookSort(bookList);
            bookStack.remove(0);
            System.out.println("복구 완료되었습니다.");
        }
    }

    public static void selectAllBooks() { // 모든 도서 조회
        bookSort(bookList);
        System.out.println("========== 모든 도서 ==========");
        for (Book book : bookList) {
            System.out.println(book.toString());
        }
        System.out.println("===============================");
    }

    public static void selectPossibleBooks() { // 대출 가능 도서 조회
        List<Book> possibleBookList = new ArrayList<>();
        // 대출 가능한 책 리스트 넣기
        for (Book book : bookList) {
            if (book.isRentState() == false) {
                possibleBookList.add(book);
            }
        }
        // 최근 출간 순서대로 정렬
        bookSort(possibleBookList);

        // 출력
        System.out.println("======== 대출 가능 도서 ========");
        for (Book book : possibleBookList) {
            System.out.println(book.toString());
        }
        System.out.println("===============================");

    }

    public static void selectImpossibleBooks() { // 대출 목록 표시 --> 대출 장부
//        List<Book> impossibleBookList = new ArrayList<>();
//        // 대출 가능한 책 리스트 넣기
//        for (Book book : bookList) {
//            if (book.isRentState() != false) {
//                impossibleBookList.add(book);
//            }
//        }
//        // 최근 출간 순서대로 정렬
//        bookSort(impossibleBookList);
//        
//        // 출력
//        System.out.println("======== 대출 불가 도서 ========");
//        for (Book book : impossibleBookList) {
//            System.out.println(book.toString());
//        }
//        System.out.println("===============================");
    }

    public static void bookSort(List<Book> list) { // 최근 출간 순서대로 책 정렬
        list.sort(new Comparator<Book>() {
            @Override
            public int compare(Book o1, Book o2) {
                return o1.getReleaseDate().compareTo(o2.getReleaseDate());
            }
        });
    }
}
