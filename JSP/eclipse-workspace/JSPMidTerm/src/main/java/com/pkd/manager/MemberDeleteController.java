package com.pkd.manager;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.repository.MemberRepository;
import com.pkd.repository.MemberRepositoryImpl;

/**
 * Servlet implementation class MemberDeleteController
 */
@WebServlet("/MemberDeleteController")
public class MemberDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MemberRepository memberRepository;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDeleteController() {
        super();
        // TODO Auto-generated constructor stub
        memberRepository = new MemberRepositoryImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    int state = memberRepository.deleteByMember(request.getParameter("id"));
        if (state == 1) {
            System.out.println("delete 성공");
        } else {
            System.out.println("delete 실패");
        }
        response.sendRedirect("./manager/main.jsp");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
