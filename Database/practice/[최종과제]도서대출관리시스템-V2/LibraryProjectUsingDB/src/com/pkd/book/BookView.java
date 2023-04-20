package com.pkd.book;

import java.util.Scanner;
import com.pkd.member.MemberController;
import com.pkd.rent.RentController;

public class BookView {
    private Scanner sc = new Scanner(System.in);
    private BookController bookController = new BookController();
    private RentController rentController = new RentController();
    private MemberController memberController = new MemberController();

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

                    // 도서 등록
                    bookController.register(bookName, releaseDateInput);
                    break;

                case 3: // 도서 수정
                    bookController.selectAll();
                    // 수정할 도서 ID 선택
                    System.out.println("수정할 도서 번호 : ");
                    int modifyBookNumber = sc.nextInt();
                    // 새 제목 받기
                    System.out.print("새 제목 : ");
                    String newBookName = sc.next();
                    // 새 출간일 받기
                    System.out.print("새 출간일(yyyy/mm/dd) : ");
                    String newReleaseDate = sc.next();

                    // 도서 수정
                    bookController.modify(modifyBookNumber, newBookName, newReleaseDate);
                    break;

                case 4: // 도서 삭제
                    bookController.selectAll();
                    // 삭제할 도서 ID 선택
                    System.out.print("삭제할 도서 번호 : ");
                    int deleteBookNumber = sc.nextInt();
                    // 도서 삭제
                    bookController.remove(deleteBookNumber);
                    break;

                case 5: // 도서 대출 관련
                    rents();
                    break;

                case 6: // 도서 삭제 취소
                    bookController.undo();
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
                bookController.selectAll();
                break;

            case 2:
                bookController.selectPossibleBooks();
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
                rentController.selectAll();
                break;

            case 2: // 도서 대출
                // 대출할 도서 선택
                bookController.selectPossibleBooks();
                System.out.print("대출 도서 ID : ");
                int bookIdInput = sc.nextInt();

                // 어떤 회원이 대출했는지 선택
                memberController.selectAll();
                System.out.print("대출 회원 ID : ");
                int memberIdInput = sc.nextInt();

                // 해당 도서 대출
                rentController.rent(bookIdInput, memberIdInput);
                break;

            case 3: // 도서 대출 연장
                rentController.selectAll();
                System.out.println("연장 할 대출 번호 : ");
                int rentId = sc.nextInt();

                // 해당 도서 7일 연장
                rentController.extend(rentId);
                break;

            case 4: // 대출 도서 반납
                rentController.selectAll();
                System.out.print("반납할 대출 번호 : ");
                int rentId2 = sc.nextInt();

                // 해당 대출 반납
                rentController.returnBook(rentId2);
                break;
            default:
                System.out.println("잘못된 입력");
                break;
        }
    }
}
