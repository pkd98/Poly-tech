package com.pkd.member;

import java.util.Scanner;

public class MemberView {
    Scanner sc = new Scanner(System.in);
    MemberController memberController = new MemberController();

    public void start() {
        while (true) {
            System.out.println("======== 회원관리 프로그램 ========");
            System.out.println(" 0. 뒤로");
            System.out.println(" 1. 회원 조회");
            System.out.println(" 2. 회원 등록");
            System.out.println(" 3. 회원 수정");
            System.out.println(" 4. 회원 삭제");
            System.out.println(" 5. 삭제 취소");
            System.out.println("===================================");
            int memberOptionInput = sc.nextInt();

            switch (memberOptionInput) {
                case 0: // 뒤로 (리턴)
                    return;

                case 1: // 회원 조회
                    memberController.selectAll();
                    break;

                case 2: // 회원 등록
                    // 이름 받기
                    System.out.print("이름 : ");
                    String name = sc.next();

                    // 주소
                    System.out.print("주소(시/군/구) : ");
                    String address1 = sc.next();
                    String address2 = sc.next();

                    // 연락처
                    System.out.print("연락처(01012345678) : ");
                    String phoneNumber = sc.next();

                    // 생일
                    System.out.print("생일(yyyy/MM/dd) : ");
                    String birthInput = sc.next();

                    // 회원 등록
                    memberController.register(name, address1 + " " + address2, phoneNumber,
                            birthInput);
                    break;

                case 3: // 회원 수정
                    // 수정할 회원 ID 선택
                    memberController.selectAll();
                    System.out.print("수정할 회원 ID : ");
                    int modifyId = sc.nextInt();

                    System.out.print("새 이름 : ");
                    String newName = sc.next();

                    System.out.print("새 주소(시/군/구) : ");
                    String newAddress1 = sc.next();
                    String newAddress2 = sc.next();

                    System.out.print("새 연락처(01012345678) : ");
                    String newPhoneNumber = sc.next();

                    System.out.print("생일 수정(yyyy/MM/dd) : ");
                    String newBirthDayInput = sc.next();

                    memberController.modify(modifyId, newName, newAddress1 + " " + newAddress2,
                            newPhoneNumber, newBirthDayInput);
                    break;

                case 4: // 회원 삭제
                    // 삭제 할 회원 ID 선택
                    memberController.selectAll();
                    System.out.println("0. 뒤로");
                    System.out.print("삭제할 ID : ");
                    int deleteId = sc.nextInt();
                    if (deleteId == 0) {
                        break;
                    }
                    memberController.remove(deleteId);
                    break;

                case 5: // 삭제 취소
                    memberController.undo();
                    break;
                default:
                    break;
            }
        }

    }
}
