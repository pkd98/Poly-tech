package com.pkd.utils;

public interface RentUtil {
    // 대출 현황
    void selectAll();

    // 도서 대출
    void rent(int bookId, int memberId);

    // 도서 반납
    void returnBook(int rentId);

    // 대출 연장
    void extend(int rentId);

    // 커밋
    void commit();
}
