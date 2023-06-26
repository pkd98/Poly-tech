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
 * Servlet implementation class LoginController
 */

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDTO member;
    private MemberRepository memberRepository;


    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
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
        request.setCharacterEncoding("UTF-8");
        member.setId(request.getParameter("id"));
        member.setPw(request.getParameter("pw"));
        System.out.println(member.getId() + member.getPw());

        MemberDTO findMember = memberRepository.findByMember(request.getParameter("id"));
        System.out.println(findMember.toString());
        // 해당 회원 없음
        if (findMember.getId() == null) {
            System.out.println("login fail : member nothing");
            response.sendRedirect("login.jsp");
        } else {
            // 비밀번호 일치
            if (member.getPw().equals(findMember.getPw())) {
                switch (findMember.getStatus()) {
                    // 가입 대기중
                    case "waiting":
                        response.sendRedirect("./user/waiting.jsp");
                        break;

                    // 정상 상태
                    case "normal":
                        // 세션 생성
                        HttpSession session = request.getSession(true);
                        session.setAttribute("id", findMember.getId());
                        session.setAttribute("name", findMember.getName());
                        session.setAttribute("phone", findMember.getPhone());
                        session.setAttribute("email", findMember.getEmail());
                        session.setAttribute("role", findMember.getRole());

                        // 일반 회원
                        if (findMember.getRole().equals("user")) {
                            System.out.println("user login success");
                            response.sendRedirect("./user/main.jsp");
                        }

                        // 관리자 로그인
                        if (findMember.getRole().equals("manager")) {
                            System.out.println("manager login success");
                            response.sendRedirect("./manager/main.jsp");
                        }
                        break;

                    // 정지 상태
                    case "pause":
                        response.sendRedirect("./user/pause.jsp");
                        break;

                    default:
                        response.sendRedirect("login.jsp");
                }
            } else {
                // 비밀번호 불일치
                System.out.println("login fail : pw not equals");
                response.sendRedirect("login.jsp");
            }
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
