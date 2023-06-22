package member;

import java.util.ArrayList;
import java.util.List;

public class test {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        MemberRepository memberRepository = new JdbcMemberRepository();
        List<Member> memberList = new ArrayList();
        Member member = new Member();
        member.setId("test");
        member.setPw("1234");
        member.setName("홍길동");
        member.setEmail("test@test.com");

        memberRepository.save(member);

        memberList = memberRepository.selectAll();
        for (Member m : memberList) {
            System.out.println(m.toString());
        }

    }
}
