package com.pkd.board.repository;

import java.util.List;
import com.pkd.board.domain.Board;

public interface BoardRepository {
    // 모든 조회
    List<Board>findAll();
    
    // 계층형 모든 글 목록 조회
    List<Board>hierarchicalFindAll();
    
    // 해당 id 레코드 보기
    Board findBoardById(int id);
    
    // 해당 id 레코드 검색
    boolean hasRecordById(int id);
    
    // 해당 board 레코드 삽입
    int insertBoard(Board board);
    
    // 해당 board 레코드 수정
    int updateBoard(Board board);
        
    // 해당 board 레코드 삭제
    int deleteBoard(int id);

    // 해당 board 조회수 증가
    int updateBoardViews(Board board);
}
