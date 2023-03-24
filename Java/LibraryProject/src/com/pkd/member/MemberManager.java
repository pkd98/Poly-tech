package com.pkd.member;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import com.pkd.book.Book;
import com.pkd.utils.Utils;

public class MemberManager {
    Scanner sc = new Scanner(System.in);

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

                case 1: // 회원 조회
                    MemberUtil.selectMember();
                    break;

                case 2: // 회원 등록
                    // ID 받기
                    System.out.print("ID : ");
                    String id = sc.next();

                    // 이름 받기
                    System.out.print("이름 : ");
                    String name = sc.next();

                    // 가입 일
                    Date signUp = new Date();

                    // 주소
                    System.out.print("주소 : ");
                    String address = sc.next();

                    // 연락처
                    System.out.print("연락처 : ");
                    String phoneNumber = sc.next();

                    // 생일
                    System.out.print("생일(yyyy/MM/dd) : ");
                    String birthInput = sc.next();
                    Date birthDay = Utils.stringToDate(birthInput);

                    // 회원 인스턴스 생성
                    Member member = new Member(id, name, signUp, address, phoneNumber, birthDay);

                    // 책 등록!
                    MemberUtil.memberRegister(member);
                    break;

                case 3: // 회원 수정
                    MemberUtil.selectMember();
                    System.out.println("수정할 회원 ID : ");
                    String modifyId = sc.next();

                    System.out.print("새 이름 : ");
                    String newName = sc.next();

                    System.out.print("새 주소 : ");
                    String newAddress = sc.next();

                    System.out.print("새 연락처 : ");
                    String newPhoneNumber = sc.next();

                    System.out.print("생일 수정(yyyy/MM/dd) : ");
                    String newBirthDayInput = sc.next();
                    Date newBirthDay = Utils.stringToDate(newBirthDayInput);

                    MemberUtil.modifyMember(modifyId, newName, newAddress, newPhoneNumber,
                            newBirthDay);
                    break;

                case 4: // 회원 삭제
                    MemberUtil.selectMember();
                    System.out.print("삭제할 ID : ");
                    String deleteId = sc.next();
                    System.out.println(deleteId);
                    MemberUtil.removeMember(deleteId);
                    break;

                case 5: // 삭제 취소
                    MemberUtil.removeUndo();
                    break;
                default:
                    break;
            }
        }

    }
}
