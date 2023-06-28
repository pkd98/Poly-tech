package com.pkd.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Controller
 */
@WebServlet("*.do")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    String uri = request.getRequestURI();
	    String conPath = request.getContextPath();
	    String command = uri.substring(conPath.length());
	    
	    System.out.println("uri: " + uri);
	    System.out.println("conPath: " + conPath);
	    System.out.println("command: " + command);
	    
	    switch(command) {
	        case "command1.do":
	            System.out.println("/command1.do");
	            System.out.println("--------------");
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
