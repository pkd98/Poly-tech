package com.pkd.member;

import java.util.Date;
import com.pkd.book.Book;

public class MemberUtil {
    
    
    
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

    public static void bookModify(int modifyBookNumber, String newBookName, Date newReleaseDate) { // 도서
                                                                                                   // 수정
        bookList.get(modifyBookNumber).setName(newBookName);
        bookList.get(modifyBookNumber).setReleaseDate(newReleaseDate);
        System.out.println("수정되었습니다.");
    }

    public static void bookRemove(int BookListIndex) { // 도서 삭제
        // 잘못된 입력 처리
        if (BookListIndex > bookList.size() - 1 || BookListIndex < 0) {
            System.out.println("잘못된 입력 입니다.");
            return;
        } else {
            bookStack.add(bookList.get(BookListIndex)); // 삭제 undo 기능을 위해 스택에 저장
            bookList.remove(BookListIndex);
            System.out.println("정상 삭제 되었습니다.");
        }
    }

    public static void bookRent() { // 도서 대출

    }

    public static void bookReturn() { // 도서 반납

    }

    public static void selectAllBooks() { // 모든 도서 조회

    }

    public static void selectPossibleBooks() { // 대출 가능 도서 조회

    }

    public static void bookSort() { // 책 정렬

    }
}
