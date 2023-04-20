package com.pkd.utils;

public interface BookUtil {
    // 도서 등록
    void register(String bName, String releaseDate);

    // 도서 수정
    void modify(int modifyBookId, String newBookName, String newReleaseDate);

    // 도서 삭제
    public void remove(int ID);

    // 도서 삭제 취소
    void undo();

    // 모든 도서 조회
    void selectAll();

    // 대출 가능 도서 조회
    void selectPossibleBooks();

    // 커밋
    void commit();
}
