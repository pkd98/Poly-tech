package com.pkd.member.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.member.domain.Member;

public interface MemberService {
    List<Member> findAllMember(HttpServletRequest request, HttpServletResponse response);
    
}
