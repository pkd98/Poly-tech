package com.pkd.member.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.member.domain.Member;
import com.pkd.member.repository.MemberRepository;

public class MemberServiceImpl implements MemberService {
    
    private final MemberRepository memberRepository;
    
    public MemberServiceImpl(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @Override
    public List<Member> findAllMember(HttpServletRequest request, HttpServletResponse response) {
        // TODO Auto-generated method stub
        return memberRepository.findAll();
    }
}
