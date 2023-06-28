package com.pkd.member.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.member.AppConfig;
import com.pkd.member.domain.Member;
import com.pkd.member.service.MemberService;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("*.do")
public class MemberController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final MemberService memberService;
    // private final MemberRepository memberRepository;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberController() {
        super();
        // TODO Auto-generated constructor stub
        AppConfig appConfig = new AppConfig();
        this.memberService = appConfig.memberService();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        String uri = request.getRequestURI();
        String conPath = request.getContextPath();
        String command = uri.substring(conPath.length());

        System.out.println("uri: " + uri);
        System.out.println("conPath: " + conPath);
        System.out.println("command: " + command);
        
        frontController(command, request, response);

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

    void frontController(String command, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        switch (command) {
            case "/findAllMember.do":
                List<Member> memberList = memberService.findAllMember(request, response);
                
                for (Member member : memberList) {
                    System.out.println(member);
                }
                
                request.setAttribute("memberList", memberList);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/dispatcherJsp.jsp");
                dispatcher.forward(request, response);
                
                break;

            case "command2.do":
                System.out.println("/command1.do");
                System.out.println("--------------");
                break;

            case "command3.do":
                System.out.println("/command1.do");
                System.out.println("--------------");
                break;
        }
    }
}
