package com.pkd;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.catalina.Session;
import com.pkd.member.JdbcMemberRepository;
import com.pkd.member.MemberDTO;
import com.pkd.member.MemberRepository;

/**
 * Servlet implementation class LoginOk
 */
@WebServlet("/LoginOk")
public class LoginOk extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String id, pw, name;
    private String query;
    private Connection conn;
    private PreparedStatement pstmt;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginOk() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        actionDo(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        actionDo(request, response);
    }

    private void actionDo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        id = request.getParameter("id");
        pw = request.getParameter("pw");
        MemberRepository memberRepository = new JdbcMemberRepository();

        MemberDTO member = memberRepository.findByMember(id);

        // 로그인 실패
        if (member.getId() == null) {
            System.out.println("login fail");
            response.sendRedirect("login.html");
        } else {
            // 로그인 성공
            if (member.getPw().equals(pw)) {
                System.out.println("login success");
                name = member.getName();

                // 로그인 세션 생성
                HttpSession session = request.getSession(true);
                session.setAttribute("id", id);
                session.setAttribute("name", name);
                session.setAttribute("email", member.getEmail());
                response.sendRedirect("loginResult.jsp");
            }
        }
    }
}
