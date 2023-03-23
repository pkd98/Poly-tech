package com.pkd.member;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import com.pkd.book.Book;
import com.pkd.book.BookUtil;
import com.pkd.utils.Utils;

public class MemberManager {
    Scanner sc = new Scanner(System.in);
    static List<Book> memberList = new ArrayList<>(); // 도서 목록
    static List<Book> memberStack = new ArrayList<>(1); // 삭제 취소를 위한 stack
    
    public void start() {
        while (true) {
            System.out.println("======== 회원관리 프로그램 ========");
            System.out.println(" 0. 뒤로");
            System.out.println(" 1. 회원 조회");
            System.out.println(" 2. 회원 등록");
            System.out.println(" 3. 회원 수정");
            System.out.println(" 4. 회원 삭제");
            System.out.println(" 5. 삭제 취소");
            System.out.println("====================================");
            int memberOptionInput = sc.nextInt();

            switch (memberOptionInput) {
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
                    int modifyBookNumber = sc.nextInt() - 1;

                    System.out.print("새 제목 : ");
                    String newBookName = sc.next();

                    System.out.print("새 출간일 : ");
                    Date newReleaseDate = Utils.stringToDate(sc.next());

                    BookUtil.bookModify(modifyBookNumber, newBookName, newReleaseDate);
                    break;

                case 4: // 도서 삭제
                    BookUtil.selectAllBooks();
                    System.out.println("삭제할 도서 번호 : ");
                    int deleteBookNumber = sc.nextInt() - 1;
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
}
