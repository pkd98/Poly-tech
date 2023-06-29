package com.pkd.board.service;

import java.util.List;
import com.pkd.board.domain.Board;
import com.pkd.board.repository.BoardRepository;

public class BoardServiceImpl implements BoardService {

    private final BoardRepository boardRepository;
    
    public BoardServiceImpl(BoardRepository boardRepository) {
        this.boardRepository = boardRepository;
    }
    
    @Override
    public List<Board> getAllArticleList() {
        return boardRepository.hierarchicalFindAll();
    }

    @Override
    public Board getArticle(int id) {
        return increaseArticleViews(id);
    }

    @Override
    public int write(Board board) {
        return boardRepository.insertBoard(board);
    }

    @Override
    public int edit(Board board) {
        return boardRepository.updateBoard(board);
    }

    @Override
    public int delete(int id) {
        return boardRepository.deleteBoard(id);
    }

    @Override
    public Board increaseArticleViews(int id) {
        Board board = boardRepository.findBoardById(id);
        boardRepository.updateBoardViews(board);
        return board;
    }

}
