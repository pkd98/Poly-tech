package com.pkd.board.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pkd.board.domain.Board;

public interface BoardService {
    
    // 모든 글 목록 조회
    List<Board>getAllArticleList();
    
    // 조회수 증가
    Board increaseArticleViews(int id);
    
    // 글 보기
    Board getArticle(int id);
    
    // 글쓰기
    int write(Board board);
    
    // 글 편집
    int edit(Board board);
    
    // 글 삭제
    int delete(int id);

}
