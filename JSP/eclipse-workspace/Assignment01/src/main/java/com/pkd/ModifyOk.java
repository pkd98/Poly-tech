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
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        id = request.getParameter("id");
        pw = request.getParameter("pw");
        name = request.getParameter("name");
        email = request.getParameter("email");

        // 해당 회원 조회
        query = "update member set pw = ?, name = ?, email = ? where id = ?";

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/da2308", "scott",
                    "tiger");
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, pw);
            pstmt.setString(2, name);
            pstmt.setString(3, email);
            pstmt.setString(4, id);

            int state = pstmt.executeUpdate();

            if (state == 1) {
                System.out.println("update success");
                response.sendRedirect("modifyResult.jsp");
            } else {
                System.out.println("update fail");
                response.sendRedirect("loginResult.jsp");
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            response.sendRedirect("join.html");
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            }
        }
    }
}
