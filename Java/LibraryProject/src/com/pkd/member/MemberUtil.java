package com.pkd.member;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.pkd.book.Book;

public class MemberUtil {

    public static List<Member> memberList = new ArrayList<>(); // 회원 목록
    public static List<Member> memberStack = new ArrayList<>(1); // 삭제 취소를 위한 stack

    public MemberUtil() {}

    // 1. 회원 등록
    public static void memberRegister(Member member) {
        int beforeSize = memberList.size();
        memberList.add(member);
        if (memberList.size() == beforeSize) {
            System.out.println("회원 등록 실패!");
        } else {
            System.out.println("정상 등록 되었습니다.");
        }
    }

    // 2. 전체 회원 조회
    public static void selectMember() {
        System.out.println("========== 회원 조회 ==========");
        for (Member member : memberList) {
            System.out.println(member.toString());
        }
        System.out.println("===============================");
    }

    // 3. 회원 수정
    public static void modifyMember(String modifyId, String newName, String newAddress,
            String newPhoneNumber, Date newBirthDay) {

        boolean checkId = false;
        for (Member member : memberList) {
            if (modifyId.equals(member.getId())) {
                member.setName(newName);
                member.setAddress(newAddress);
                member.setPhoneNumber(newPhoneNumber);
                member.setBirthDay(newBirthDay);
                checkId = true;
            }
        }
        if (checkId == true)
            System.out.println("수정되었습니다.");
        else
            System.out.println("잘못된 ID입니다.");
    }


    // 4. 회원 삭제
    public static void removeMember(String ID) {
        boolean check = false;
        // ID 같은 값을 제거
        for (Member member : memberList) {
            if (member.getId().equals(ID)) {
                memberStack.add(member); // 삭제 undo 기능을 위해 스택에 저장
                memberList.remove(member);
                check = true;
                break;
            }
        }
        if (check == true)
            System.out.println("정상 삭제 되었습니다.");
        else
            System.out.println("잘못된 입력 입니다.");
    }

    // 5. 회원 삭제 취소 (1명)
    public static void removeUndo() {
        if (memberStack.size() == 0) {
            System.out.println("삭제 취소할 회원이 없습니다.");
        } else {
            memberList.add(memberStack.get(0));
            memberStack.remove(0);
            System.out.println("복구 완료되었습니다.");
        }
    }

}
