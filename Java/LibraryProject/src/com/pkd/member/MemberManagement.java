package com.pkd.member;

public interface MemberManagement {
    // 1. 회원 등록
    public void register();
    // 2. 전체 회원 조회
    public void selecetMember();
    // 3. 회원 수정
    public void rentingMember();
    // 4. 회원 삭제
    public void memberDelete();
    // 5. 회원 삭제 취소 (1명)
    public void memberDeleteUndo();
}
