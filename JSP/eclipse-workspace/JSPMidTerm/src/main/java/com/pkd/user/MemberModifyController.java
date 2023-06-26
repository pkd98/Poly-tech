package com.pkd.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.pkd.repository.MemberDTO;
import com.pkd.repository.MemberRepository;
import com.pkd.repository.MemberRepositoryImpl;

/**
 * Servlet implementation class ModifyController
 */
@WebServlet("/MemberModifyController")
public class MemberModifyController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDTO member;
    private MemberRepository memberRepository;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberModifyController() {
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
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        member.setId(request.getParameter("id"));
        member.setPw(request.getParameter("pw"));
        member.setPhone(request.getParameter("phone"));
        member.setEmail(request.getParameter("email"));

        int state = memberRepository.updateByMember(member);

        if (state == 1) {
            System.out.println("modify 성공");

            HttpSession session = request.getSession(false);

            if (session != null) {
                session.setAttribute("phone", member.getPhone());
                session.setAttribute("email", member.getEmail());
            }

            response.sendRedirect("./user/main.jsp");
        } else {
            System.out.println("modify 실패");
            response.sendRedirect("./user/modify.jsp");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
