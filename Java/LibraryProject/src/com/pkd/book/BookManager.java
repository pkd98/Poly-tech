package com.pkd.book;

import java.util.Date;
import java.util.Scanner;
import com.pkd.utils.Utils;

public class BookManager {
    private Scanner sc = new Scanner(System.in);

    public BookManager() {}

    public void start() {
        while (true) {
            System.out.println("======== 도서관리 프로그램 ========");
            System.out.println(" 0. 뒤로");
            System.out.println(" 1. 도서 조회");
            System.out.println(" 2. 도서 등록");
            System.out.println(" 3. 도서 수정");
            System.out.println(" 4. 도서 삭제");
            System.out.println(" 5. 도서 대출");
            System.out.println(" 6. 도서 반납");
            System.out.println("====================================");
            int bookOptionInput = sc.nextInt();

            switch (bookOptionInput) {
                case 0: // 뒤로 (리턴)
                    return;

                case 1: // 도서 조회 -> 1) 전체 도서, 2) 대출 가능한 도서 (최근 출간된 순서)
                    selectBook();
                    break;

                case 2: // 도서 등록
                    // 도서 제목 받기
                    System.out.print("도서 제목 : ");
                    String bookName = sc.next();
                    
                    // 도서 출간일 받기
                    System.out.print("출간 일(yyyy/MM/dd): ");
                    String releaseDateInput = sc.next();
                    Date releaseDate = Utils.stringToDate(releaseDateInput);
                    
                    // 책 인스턴스 생성
                    Book book = new Book(bookName, releaseDate);                     
                    // 책 등록!
                    BookUtil.bookRegister(book); // 등록 결과는 해당 메서드에서 처리
                    break;

                case 3: // 도서 수정
                    BookUtil.selectAllBooks();
                    System.out.println("수정할 도서 번호 : ");
                    int modifyBookNumber = sc.nextInt();
                    
                    System.out.print("새 제목 : ");
                    String newBookName = sc.next();
                    
                    System.out.print("새 출간일 : ");
                    Date newReleaseDate = Utils.stringToDate(sc.next());
                    
                    BookUtil.bookModify(modifyBookNumber, newBookName, newReleaseDate);
                    break;

                case 4: // 도서 삭제
                    BookUtil.selectAllBooks();
                    System.out.println("삭제할 도서 번호 : ");
                    int deleteBookNumber = sc.nextInt();
                    BookUtil.bookRemove(deleteBookNumber);
                    break;

                case 5: // 도서 대출
                    BookUtil.bookRent();
                    break;
                
                case 6:
                    BookUtil.bookReturn();

                default:
                    break;
            }
        }
    }

    public void selectBook() {
        System.out.println("========== 도서 조회 ==========");
        System.out.println(" 0. 뒤로");
        System.out.println(" 1. 도서 전체 조회");
        System.out.println(" 2. 대출 가능한 도서 조회");
        System.out.println("===============================");
        int selectInput = sc.nextInt();

        switch (selectInput) {
            case 0:
                return;

            case 1:
                BookUtil.selectAllBooks();
                break;

            case 2:
                BookUtil.selectPossibleBooks();
                break;
        }
    }
}
