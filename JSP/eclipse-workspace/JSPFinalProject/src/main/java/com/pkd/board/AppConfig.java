package com.pkd.board;

import com.pkd.board.repository.BoardRepository;
import com.pkd.board.repository.JdbcBoardRepository;
import com.pkd.board.service.BoardService;
import com.pkd.board.service.BoardServiceImpl;

public class AppConfig {

    public BoardService BoardService() {
        return new BoardServiceImpl(getBoardRepository());
    }

    public BoardRepository getBoardRepository() {
        return JdbcBoardRepository.getInstance();
    }
}
