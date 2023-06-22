package com.pkd;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class JoinOk
 */
@WebServlet("/JoinOk")
public class JoinOk extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String name, id, pw, email, gender;
    private String query;
    private Connection conn;
    private Statement stmt;

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
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");

        name = request.getParameter("name");
        id = request.getParameter("id");
        pw = request.getParameter("pw");
        email = request.getParameter("email");
        gender = request.getParameter("gender");

        query = "insert into member(name, id, pw, email, gender) values('" + name + "','" + id
                + "','" + pw + "','" + email + "','" + gender + "')";

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/da2308", "scott",
                    "tiger");
            stmt = conn.createStatement();
            int iResult = stmt.executeUpdate(query);

            if (iResult == 1) {
                System.out.println("insert success");
                response.sendRedirect("joinResult.jsp");
            } else {
                System.out.println("insert fail");
                response.sendRedirect("join.html");
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            response.sendRedirect("join.html");
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            }
        }

    }

}
