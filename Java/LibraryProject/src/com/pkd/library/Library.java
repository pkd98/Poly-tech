package com.pkd.library;

import java.util.Scanner;
import com.pkd.book.BookManager;
import com.pkd.member.MemberManager;
import com.pkd.member.MemberUtil;
import com.pkd.mode.SaveManager;
import com.pkd.mode.SaveMode;
import com.pkd.mode.SaveUtil;

public class Library {

    //private ManagementMode mode;
    private Scanner sc = new Scanner(System.in);
    private String currentMode;
    private int modeInput;
    
    public void libraryStart() {
        boolean control = true;
        while (control) {
            System.out.println("==================================");
            System.out.println("1. 테스트 모드");
            System.out.println("2. 도서관 관리 프로그램 시작");
            System.out.println("==================================");
            modeInput = sc.nextInt();

            switch (modeInput) {
                case 1:
                    // 테스트 모드 설정 (저장 기능 Off)
                    SaveManager saveManager1 = new SaveManager(SaveMode.NO_SAVE);
                    currentMode = "===========테스트 모드============";
                    control = false;
                    break;

                case 2:
                    // 일반 저장 모드 (저장 기능 On)
                    SaveManager saveManager2 = new SaveManager(SaveMode.YES_SAVE);
                    currentMode = "==== KOPO-PKD 도서관리 시스템 ====";
                    control = false;
                    break;

                default:
                    System.out.println("잘못 입력 하셨습니다.");
                    continue;
            }
        }
        
        while (true) {
            System.out.println(currentMode);
            System.out.println("1. 도서 관리");
            System.out.println("2. 회원 관리");
            System.out.println("3. 종료");
            System.out.println("==================================");
            int selectInput = sc.nextInt();

            switch (selectInput) {
                case 1: // 도서 관리 프로그램 시작
                    BookManager bookManager = new BookManager();
                    bookManager.start();
                    break;
                    
                case 2: // 회원 관리 프로그램 시작
                    MemberManager memberManager = new MemberManager();
                    memberManager.start();
                    break;
                    
                case 3: // 종료
                    System.out.println("프로그램을 종료합니다.");
                    // csv 저장 코드 추가
                    SaveUtil.bookToCsv();
                    SaveUtil.memberToCsv();
                    SaveUtil.rentToCsv();
                    System.exit(1);
                    break;

                default:
                    System.out.println("잘못 입력 하셨습니다.");
                    continue;
            }
        }
    }
}

