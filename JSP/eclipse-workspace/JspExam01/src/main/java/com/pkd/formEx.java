package com.pkd;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class formEx
 */
@WebServlet("/formEx")
public class formEx extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public formEx() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doPost");

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String id = request.getParameter("id");
        String passWord = request.getParameter("passWord");
        String[] hobby = request.getParameterValues("hobby");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter pw = response.getWriter();
        
        pw.println("<html>");
        pw.println("<head>");
        pw.println("</head>");
        pw.println("<body>");
        
        pw.println("이름 : " + name + "<br/>");
        pw.println("아이디 : " + id + "<br/>");
        pw.println("비밀번호 : " + passWord + "<br/>");
        pw.print("취미 : ");

        for (int i = 0; i < hobby.length; i++) {
            pw.print(hobby[i] + " ");
        }
        
        pw.println("</body>");
        pw.println("</html>");
        pw.close();
    }
}
