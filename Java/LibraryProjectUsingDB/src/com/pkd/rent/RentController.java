package com.pkd.rent;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import com.pkd.book.BookController;
import com.pkd.utils.RentUtil;
import com.pkd.utils.Utils;

public class RentController implements RentUtil {
    BookController bookController = new BookController();

    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet deleteTempResultSet = null;
    ResultSet rs = null;
    Connection conn = Utils.getOracleConnect();

    public RentController() {}

    // 대출 현황 조회
    @Override
    public void selectAll() {
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(
                    "SELECT RID, MID, BID, TO_CHAR(RENT_DATE, 'YYYY/MM/DD') AS RENT_DATE,"
                            + "CASE WHEN RENT_EXTENTION_STATE = 'T' THEN '연장 불가능'"
                            + "WHEN RENT_EXTENTION_STATE = 'F' THEN '연장 가능' END AS EXTENTION_STATE,"
                            + " TO_CHAR(RETURN_DATE, 'YYYY/MM/DD') AS RETURN_DATE"
                            + " FROM RENT ORDER BY RETURN_DATE ASC");


            System.out.println("============== 대출 현황 ==============");
            while (rs.next()) {
                System.out.println("RID : " + rs.getInt("RID") + " 회원ID : " + rs.getInt("MID")
                        + " 도서ID : " + rs.getInt("BID") + " 대출일 : " + rs.getString("RENT_DATE")
                        + "\n 반납일 : " + rs.getString("RETURN_DATE") + " 연장 상태 : "
                        + rs.getString("EXTENTION_STATE") + "\n");
            }
            System.out.println("=======================================");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 도서 대출
    @Override
    public void rent(int bookId, int memberId) {
        try {
            pstmt = conn.prepareStatement(
                    "INSERT INTO RENT(RID, BID, MID)" + "VALUES(RENT_SEQ.NEXTVAL, ?, ?)");

            pstmt.setInt(1, bookId);
            pstmt.setInt(2, memberId);
            pstmt.executeUpdate();
            bookController.modify(bookId); // 도서 대출 상태 수정
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("대출 등록 실패!");
            return;
        }
        System.out.println("대출 처리 되었습니다.");
    }

    // 도서 반납
    @Override
    public void returnBook(int rentId) {
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT BID FROM RENT WHERE RID = " + rentId);
            int bId = 0;

            // 반납할 도서 ID 추출
            while (rs.next()) {
                bId = rs.getInt("BID");
            }

            // 해당 도서 삭제
            pstmt = conn.prepareStatement("DELETE FROM RENT WHERE RID = ?");
            pstmt.setInt(1, rentId);
            pstmt.executeUpdate();
            bookController.modify(bId); // 도서 대출 상태 수정
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("도서 반납 실패!");
            return;
        }
        System.out.println("정상 반납 처리되었습니다.");
    }

    // 대출 연장
    @Override
    public void extend(int rentId) {
        try {
            // 대출 연장 대상 데이터
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM RENT WHERE RID = " + rentId);

            // 연장 상태 불가능 처리 (제약 조건)
            while (rs.next()) {
                if (rs.getString("RENT_EXTENTION_STATE").equals("T")) {
                    System.out.println("연장이 불가합니다.");
                    return;
                }
            }

            // 해당 대출 연장 처리
            pstmt = conn.prepareStatement(
                    "UPDATE RENT SET RENT_EXTENTION_STATE = 'T', RETURN_DATE = RETURN_DATE + 7 WHERE RID = ?");
            pstmt.setInt(1, rentId);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("도서 대출 연장 실패!");
            return;
        }
        System.out.println("반납 기한 7일 연장되었습니다.");
    }

    // 커밋
    @Override
    public void commit() {
        try {
            pstmt = conn.prepareStatement("commit");
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("커밋 실패!");
            return;
        }
        System.out.println("정상 커밋 되었습니다.");
    }
}
