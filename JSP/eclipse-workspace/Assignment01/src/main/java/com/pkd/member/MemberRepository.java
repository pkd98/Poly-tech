package com.pkd.member;

import java.util.List;

public interface MemberRepository {

    List<MemberDTO> findAll();

    int join(MemberDTO member);

    MemberDTO findByMember(String id);

    int updateByMember(MemberDTO member);
}
