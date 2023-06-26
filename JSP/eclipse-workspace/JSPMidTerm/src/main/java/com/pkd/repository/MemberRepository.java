package com.pkd.repository;

import java.util.List;

public interface MemberRepository {
    
    // 회원 가입
    int join(MemberDTO member);
    
    // 회원 탈퇴 요청
    int withdraw(String id);

    // 회원 조회
    MemberDTO findByMember(String id);
    
    // 회원 정보 수정 (사용자)
    int updateByMember(MemberDTO member);
    
    // 모든 사용자 조회 (관리자)
    List<MemberDTO> findAll();
    
    // 가입 요청 사용자 조회 (관리자)
    List<MemberDTO> findByWaitingMember();
    
    // 탈퇴 요청 사용자 조회 (관리자)
    List<MemberDTO> findByWithdrawRequestMember();
    
    // 회원 정보 수정 (관리자)
    int updateByMemberForManager(MemberDTO member);

    // 회원 상태 수정 (관리자)
    int updateByState(String id, int state); // 0: waiting, 1: normal, 2: pause
    
    // 회원 권한 수정 (관리자)
    int updateByRole(String id, boolean isManager); // false: user, true: manager
    
    // 회원 삭제 (관리자)
    int deleteByMember(String id);

}
