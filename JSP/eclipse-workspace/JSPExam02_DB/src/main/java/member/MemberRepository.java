package member;

import java.util.List;

public interface MemberRepository {

    void save(Member member);
    
    List<Member> selectAll();
}
