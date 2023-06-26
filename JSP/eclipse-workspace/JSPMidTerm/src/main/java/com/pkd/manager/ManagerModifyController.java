package com.pkd.manager;

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
 * Servlet implementation class ManagerModifyController
 */
@WebServlet("/ManagerModifyController")
public class ManagerModifyController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDTO member;
    private MemberRepository memberRepository;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerModifyController() {
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
        member.setPhone(request.getParameter("phone"));
        member.setEmail(request.getParameter("email"));
        member.setStatus(request.getParameter("status"));
        member.setRole(request.getParameter("role"));
        member.setWithdraw(request.getParameter("withdraw"));

        int state = memberRepository.updateByMemberForManager(member);

        if (state == 1) {
            System.out.println("modify 성공");
            response.sendRedirect("./manager/main.jsp");
        } else {
            System.out.println("modify 실패");
            response.sendRedirect("./manager/main.jsp");
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
