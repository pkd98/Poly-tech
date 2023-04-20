package com.pkd.library;

import java.sql.PreparedStatement;
import java.util.Scanner;
import com.pkd.book.BookView;
import com.pkd.member.MemberView;
import com.pkd.utils.Utils;

public class Library {

    public static void main(String[] args) {
        Library library = new Library();
        library.libraryStart();
    }

    private Scanner sc = new Scanner(System.in);
    PreparedStatement pstmt = null;

    public void libraryStart() {

        while (true) {
            System.out.println("====== 도서 대출 관리 시스템 ver2 ======");
            System.out.println("1. 도서 관리");
            System.out.println("2. 회원 관리");
            System.out.println("3. 종료");
            System.out.println("========================================");

            int selectInput = sc.nextInt();

            switch (selectInput) {
                case 1: // 도서 관리 프로그램 시작
                    BookView bookManager = new BookView();
                    bookManager.start();
                    break;

                case 2: // 회원 관리 프로그램 시작
                    MemberView memberManager = new MemberView();
                    memberManager.start();
                    break;

                case 3: // 종료
                    System.out.println("프로그램을 종료합니다.");
                    Utils.connectionClose();
                    System.exit(1);
                    break;

                default:
                    System.out.println("잘못 입력 하셨습니다.");
                    continue;
            }
        }
    }
}

