package com.pkd.member.repository;

import java.util.List;
import com.pkd.member.domain.Member;

public interface MemberRepository {
    
    List<Member>findAll();
}
