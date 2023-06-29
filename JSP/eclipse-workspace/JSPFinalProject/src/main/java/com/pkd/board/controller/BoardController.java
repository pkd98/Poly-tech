package com.pkd.board.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.board.AppConfig;
import com.pkd.board.domain.Board;
import com.pkd.board.service.BoardService;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("*.do")
public class BoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private List<Board> boardList;
    private Board board;
    private final BoardService boardService;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardController() {
        super();
        AppConfig appConfig = new AppConfig();
        this.boardService = appConfig.BoardService();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        frontController(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        frontController(request, response);
    }

    String isSuccess(int queryState) {
        String message = (queryState == 1) ? "success" : "fail";
        return message;
    }

    void frontController(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String uri = request.getRequestURI();
        String conPath = request.getContextPath();
        String command = uri.substring(conPath.length());
        String goToPage = "/main.jsp";
        Boolean forwardState = false;
        // System.out.println("uri: " + uri);
        // System.out.println("conPath: " + conPath);
        // System.out.println("command: " + command);

        switch (command) {
            // 메인 화면 모든 게시글 조회
            case "/main.do":
                forwardState = true;
                System.out.println("모든 게시글 조회");
                goToPage = "/main.jsp";
                boardList = boardService.getAllArticleList();
                request.setAttribute("allArticleList", boardList);
                break;

            // 글쓰기
            case "/write.do":
                forwardState = false;
                board = new Board();
                board.setName(request.getParameter("name"));
                board.setTitle(request.getParameter("title"));
                board.setContent(request.getParameter("content"));
                board.setDepth(0);
                int writeState = boardService.write(board);
                System.out.println("write " + isSuccess(writeState));
                break;

            // 글 답변
            case "/reply.do":
                forwardState = false;
                board = new Board();
                board.setName(request.getParameter("name"));
                board.setTitle(request.getParameter("title"));
                board.setContent(request.getParameter("content"));
                board.setParentId(Integer.parseInt(request.getParameter("parentId")));
                board.setDepth(Integer.parseInt(request.getParameter("depth")) + 1);
                int replyState = boardService.write(board);
                System.out.println("reply " + isSuccess(replyState));
                break;

            // 글 보기
            case "/detail.do":
                forwardState = true;
                goToPage = "/detail.jsp";
                System.out.println("상세 보기");
                board = boardService.getArticle(Integer.parseInt(request.getParameter("id")));
                request.setAttribute("board", board);
                break;

            // 글 수정
            case "/edit.do":
                forwardState = false;
                board = new Board();
                board.setId(Integer.parseInt(request.getParameter("id")));
                board.setTitle(request.getParameter("title"));
                board.setContent(request.getParameter("content"));
                int editState = boardService.edit(board);
                System.out.println("edit " + isSuccess(editState));
                break;

            // 글 삭제
            case "/delete.do":
                forwardState = false;
                String[] selectedIds = (request.getParameterValues("selectedIds") == null)
                        ? new String[] {request.getParameter("id")}
                        : request.getParameterValues("selectedIds");

                for (String id : selectedIds) {
                    int deleteState = boardService.delete(Integer.parseInt(id));
                    System.out.println("delete " + isSuccess(deleteState));
                }
                break;

            default:
                System.out.println("잘못된 접근");
                break;
        }
        
        if (forwardState) {
            RequestDispatcher mainDispatcher = request.getRequestDispatcher(goToPage);
            mainDispatcher.forward(request, response);
        } else {
            response.sendRedirect("main.do");
        }
    }
}
