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
 * Servlet implementation class MemberWithdrawController
 */
@WebServlet("/MemberWithdrawController")
public class MemberWithdrawController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDTO member;
    private MemberRepository memberRepository;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberWithdrawController() {
        super();
        // TODO Auto-generated constructor stub
        this.member = new MemberDTO();
        this.memberRepository = new MemberRepositoryImpl();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        int state = memberRepository.withdraw(request.getParameter("id"));

        if (state == 1) {
            System.out.println("탈퇴 요청 성공");

            HttpSession session = request.getSession(false);
            if (session != null) {
                // 세션 종료
                session.invalidate();
            }

            response.sendRedirect("./index.html");
        } else {
            System.out.println("modify 실패");
            response.sendRedirect("./user/main.jsp");
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
