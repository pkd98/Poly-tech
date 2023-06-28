package com.pkd.member;

import com.pkd.member.repository.MemberRepository;
import com.pkd.member.repository.MemoryMemberRepository;
import com.pkd.member.service.MemberService;
import com.pkd.member.service.MemberServiceImpl;

public class AppConfig {

    public MemberService memberService() {
        return new MemberServiceImpl(getMemberRepository());
    }

    public MemberRepository getMemberRepository() {
        return new MemoryMemberRepository();
    }
}
