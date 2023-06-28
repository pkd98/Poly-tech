package com.pkd.member.repository;

import java.util.ArrayList;
import java.util.List;
import com.pkd.member.domain.Member;

public class MemoryMemberRepository implements MemberRepository {

    List<Member> memberList = new ArrayList<>();
    Member member1 = new Member("user1", "1234", "홍길동");
    Member member2 = new Member("user2", "1234", "홍길순");
    Member member3 = new Member("user3", "1234", "홍길이");
    
    
    @Override
    public List<Member> findAll() {
        // TODO Auto-generated method stub
        memberList.add(member1);
        memberList.add(member2);
        memberList.add(member3);
        return memberList;
    }

}
