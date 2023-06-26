package com.pkd.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.repository.MemberDTO;
import com.pkd.repository.MemberRepository;
import com.pkd.repository.MemberRepositoryImpl;

/**
 * Servlet implementation class JoinController
 */

@WebServlet("/JoinController")
public class JoinController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDTO member;
    private MemberRepository memberRepository;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinController() {
        super();
        // TODO Auto-generated constructor stub
        this.memberRepository = new MemberRepositoryImpl();
        this.member = new MemberDTO();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // System.out.println("doGet");
        request.setCharacterEncoding("UTF-8");
        member.setId(request.getParameter("id"));
        member.setPw(request.getParameter("pw"));
        member.setName(request.getParameter("name"));
        member.setPhone(request.getParameter("phone"));
        member.setEmail(request.getParameter("email"));

        int state = memberRepository.join(member);

        if (state == 1) {
            System.out.println("join 성공");
            response.sendRedirect("./user/index.jsp");
        } else {
            System.out.println("join 실패");
            response.sendRedirect("./user/join.html");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        // System.out.println("doPost");
        doGet(request, response);
    }
}
