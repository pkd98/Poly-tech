package com.pkd;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.member.JdbcMemberRepository;
import com.pkd.member.MemberDTO;
import com.pkd.member.MemberRepository;

/**
 * Servlet implementation class JoinOk
 */
@WebServlet("/JoinOk")
public class JoinOk extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String name, id, pw, email, gender;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinOk() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        System.out.println("doGet");
        actionDo(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        System.out.println("doPost");
        actionDo(request, response);
    }

    private void actionDo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        name = request.getParameter("name");
        id = request.getParameter("id");
        pw = request.getParameter("pw");
        email = request.getParameter("email");
        gender = request.getParameter("gender");
        MemberDTO member = new MemberDTO(name, id, pw, email, gender);

        MemberRepository memberRepository = new JdbcMemberRepository();
        int state = memberRepository.join(member);

        if (state == 1) {
            response.sendRedirect("joinResult.jsp");
        } else {
            response.sendRedirect("join.html");
        }
    }
}
