package com.pkd.utils;

public interface MemberUtil {
    // 회원 등록
    void register(String mName, String address, String phoneNumber, String birthday);

    // 회원 수정
    void modify(int mId, String mName, String address, String phoneNumber, String birthday);

    // 회원 삭제
    public void remove(int ID);

    // 회원 삭제 취소
    void undo();

    // 모든 회원 조회
    void selectAll();

    // 커밋
    void commit();
}
