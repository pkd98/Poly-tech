package com.pkd.book;

import java.util.Date;
import java.util.Scanner;
import com.pkd.member.Member;
import com.pkd.member.MemberUtil;
import com.pkd.rent.Rent;
import com.pkd.rent.RentUtil;
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
            System.out.println(" 5. 도서 대출 관련");
            System.out.println(" 6. 도서 삭제 취소");
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

                case 5: // 도서 대출 관련
                    rents();
                    break;

                case 6: // 도서 삭제 취소
                    BookUtil.bookUndo();
                    break;
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
            default:
                System.out.println("잘못된 입력");
                break;
        }
    }

    public void rents() {
        System.out.println("========== 대출 관련 ==========");
        System.out.println(" 0. 뒤로");
        System.out.println(" 1. 대출중 도서 조회");
        System.out.println(" 2. 도서 대출");
        System.out.println(" 3. 도서 대출 연장");
        System.out.println(" 4. 도서 반납");
        System.out.println("===============================");
        int selectInput = sc.nextInt();

        switch (selectInput) {
            case 0:
                return;

            case 1: // 대출중 도서 조회
                RentUtil.selectRent();
                break;

            case 2: // 도서 대출
                // 대출할 도서 선택
                BookUtil.selectPossibleBooks();
                System.out.print("대출할 도서 ID : ");
                int bookIdInput = sc.nextInt();

                // 어떤 회원이 대출했는지 선택
                MemberUtil.selectMember();
                System.out.print("대출 회원 ID : ");
                String memberIdInput = sc.next();

                // 유효성 검사
                boolean checkMemberId = false;
                for (Member member : MemberUtil.memberList) {
                    if (member.getId().equals(memberIdInput)) {
                        checkMemberId = true;
                    }
                }
                if (checkMemberId == false) {
                    break;
                }

                // 해당 도서 rent 상태 true 처리
                boolean check = false;
                for (Book book1 : BookUtil.bookList) {
                    if (book1.getBookId() == bookIdInput) {
                        book1.setRentState(true);
                        check = true;
                    }
                }
                if (check == true) {
                    System.out.println("대출 처리 되었습니다.");
                } else {
                    System.out.println("잘못된 입력입니다.");
                    break;
                }

                RentUtil.bookRent(bookIdInput, memberIdInput);
                break;
            case 3: // 도서 대출 연장
                BookUtil.selectAllBooks();
                System.out.println("연장 할 도서 번호 : ");
                int bookNum = sc.nextInt();
                boolean check3 = false;
                for (Book book : BookUtil.bookList) {
                    if (book.getBookId() == bookNum) {
                        check3 = true;
                    }
                }
                if (check3 == false) {
                    System.out.println("잘못된 입력입니다.");
                }
                boolean check33 = false;
                Rent targetRent = null;
                for (Rent rent : RentUtil.rentList) {
                    if (rent.getBookId() == bookNum) {
                        targetRent = rent;
                        check33 = true;
                    }
                }
                if (check33 == false) {
                    System.out.println("대출중인 도서가 아닙니다.");
                } else {
                    RentUtil.extend(targetRent);
                }
                break;
            case 4: // 도서 반납
                BookUtil.selectAllBooks();
                System.out.print("반납할 대출 번호 : ");
                int rentNum = sc.nextInt();
                boolean check4 = false;
                Rent targetRent4 = null;
                for (Rent rent : RentUtil.rentList) {
                    if (rent.getRentId() == rentNum) {
                        targetRent4 = rent;
                        check4 = true;
                    }
                }
                if (check4 == false) {
                    System.out.println("잘못된 입력입니다.");
                } else {
                    RentUtil.bookReturn(targetRent4);
                    System.out.println("정상 반납처리 되었습니다.");
                }
                break;
        }
    }
}
