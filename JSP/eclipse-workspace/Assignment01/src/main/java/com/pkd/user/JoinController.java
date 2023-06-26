package com.pkd.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class JoinController
 */

@WebServlet("/JoinController")
public class JoinController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String id;
    private String pw;
    private String name;
    private String phone;
    private String email;

    private MemberDTO member;
    private MemberRepository memberRepository;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinController() {
        super();
        // TODO Auto-generated constructor stub
        memberRepository = new MemberRepositoryImpl();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doGet");
        request.setCharacterEncoding("UTF-8");
        id = request.getParameter("id");
        pw = request.getParameter("pw");
        name = request.getParameter("name");
        phone = request.getParameter("phone");
        email = request.getParameter("email");

        member.setId(id);
        member.setPw(pw);
        member.setName(name);
        member.setPhone(phone);
        member.setEmail(email);

        int state = memberRepository.join(member);

        if (state == 1) {
            System.out.println("join 성공");
            response.sendRedirect("./user/index.jsp");
        } else {
            System.out.println("join 실패");
            response.sendRedirect("join.html");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        System.out.println("doPost");
        doGet(request, response);
    }
}
