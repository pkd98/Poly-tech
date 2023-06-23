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
import com.pkd.member.JdbcMemberRepository;
import com.pkd.member.MemberDTO;
import com.pkd.member.MemberRepository;

/**
 * Servlet implementation class ModifyOk
 */
@WebServlet("/ModifyOk")
public class ModifyOk extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String id, pw, name, email;
    private String query;
    private Connection conn;
    private PreparedStatement pstmt;


    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyOk() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doGet");
        actionDo(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doPost");
        actionDo(request, response);
    }

    private void actionDo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        id = request.getParameter("id");
        pw = request.getParameter("pw");
        name = request.getParameter("name");
        email = request.getParameter("email");
        MemberDTO member = new MemberDTO(name, id, pw, email, null);

        MemberRepository memberRepository = new JdbcMemberRepository();
        int state = memberRepository.updateByMember(member);

        if (state == 1) {
            System.out.println("update success");
            response.sendRedirect("modifyResult.jsp");
        } else {
            System.out.println("update fail");
            response.sendRedirect("loginResult.jsp");
        }

    }
}
