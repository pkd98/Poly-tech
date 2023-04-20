package com.pkd.book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import com.pkd.utils.BookUtil;
import com.pkd.utils.Utils;

public class BookController implements BookUtil {
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet deleteTempResultSet = null;
    ResultSet rs = null;
    Connection conn = Utils.getOracleConnect();

    public BookController() {}

    // 도서 등록
    @Override
    public void register(String bName, String releaseDate) {
        try {
            pstmt = conn.prepareStatement("INSERT INTO BOOK(BID, BNAME, RELEASE_DATE)"
                    + "VALUES(BOOK_SEQ.NEXTVAL, ?, ?)");

            pstmt.setString(1, bName);
            pstmt.setString(2, releaseDate);

            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("도서 등록 실패!");
            return;
        }
        System.out.println("정상 등록 되었습니다.");
    }

    // 도서 수정
    @Override
    public void modify(int modifyBookId, String newBookName, String newReleaseDate) {
        try {
            pstmt = conn
                    .prepareStatement("UPDATE BOOK SET BNAME = ?, RELEASE_DATE = ? WHERE BID = ?");
            pstmt.setString(1, newBookName);
            pstmt.setString(2, newReleaseDate);
            pstmt.setInt(3, modifyBookId);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("도서 수정 실패!");
            return;
        }
        System.out.println("정상 수정 되었습니다.");
    }

    // 도서 대출 상태 수정
    public void modify(int modifyBookId) {
        try {
            // 대출 대상
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT RENT_STATE FROM BOOK WHERE BID = " + modifyBookId);
            String rentState = "";

            // 대출 중 도서 상태 확인
            while (rs.next()) {
                rentState = rs.getString("RENT_STATE");
            }

            // 도서 상태 토글
            if (rentState.equals("F")) {
                pstmt = conn.prepareStatement("UPDATE BOOK SET RENT_STATE = 'T' WHERE BID = ?");
                pstmt.setInt(1, modifyBookId);
            } else if (rentState.equals("T")) {
                pstmt = conn.prepareStatement("UPDATE BOOK SET RENT_STATE = 'F' WHERE BID = ?");
                pstmt.setInt(1, modifyBookId);
            }

            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("도서 대출 상태 수정 실패!");
            return;
        }
        System.out.println("정상 수정 되었습니다.");
    }


    // 도서 삭제
    @Override
    public void remove(int bId) {
        try {
            // 삭제 대상 데이터
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM BOOK WHERE BID = " + bId);
            // Undo를 위한 삭제 대상 데이터 임시 저장
            stmt = conn.createStatement();
            deleteTempResultSet = stmt.executeQuery(
                    "SELECT BID, BNAME, TO_CHAR(RELEASE_DATE, 'YYYY/MM/DD') AS RELEASE_DATE FROM BOOK WHERE BID = "
                            + bId);

            // 대출 중 도서 삭제 불가 (제약 조건)
            while (rs.next()) {
                if (rs.getString("RENT_STATE").equals("T")) {
                    System.out.println("대출 중인 도서는 삭제할 수 없습니다.");
                    deleteTempResultSet = null;
                    return;
                }
            }

            // 해당 도서 삭제
            pstmt = conn.prepareStatement("DELETE FROM BOOK WHERE BID = ?");
            pstmt.setInt(1, bId);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("도서 삭제 실패!");
            return;
        }
        System.out.println("정상 삭제 되었습니다.");
    }

    // 도서 삭제 취소
    @Override
    public void undo() {
        try {
            // 복구는 한번만 가능
            if (deleteTempResultSet == null) {
                System.out.println("삭제 복구할 도서가 없습니다.");
                return;
            }

            int bid = 0;
            String bName = "";
            String releaseDate = "";

            while (deleteTempResultSet.next()) {
                bid = deleteTempResultSet.getInt("BID");
                bName = deleteTempResultSet.getString("BNAME");
                releaseDate = deleteTempResultSet.getString("RELEASE_DATE");
            }

            pstmt = conn
                    .prepareStatement("INSERT INTO BOOK(BID, BNAME, RELEASE_DATE) VALUES(?, ?, ?)");
            pstmt.setInt(1, bid);
            pstmt.setString(2, bName);
            pstmt.setString(3, releaseDate);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("도서 삭제 취소 실패!");
            return;
        }
        deleteTempResultSet = null;
        System.out.println("정상 삭제 복구 되었습니다.");
    }

    // 모든 도서 조회
    @Override
    public void selectAll() {
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(
                    "SELECT BID, BNAME, TO_CHAR(RELEASE_DATE, 'YYYY/MM/DD') AS RELEASE_DATE, "
                            + "CASE" + " WHEN RENT_STATE = 'T' THEN '대출 불가능'"
                            + "WHEN RENT_STATE = 'F' THEN '대출 가능'" + "END AS RENT_STATE"
                            + " FROM BOOK ORDER BY RELEASE_DATE DESC");
            System.out.println("========== 모든 도서 ==========");
            while (rs.next()) {
                System.out.println("BID : " + rs.getInt("BID") + " 도서명 : " + rs.getString("BNAME")
                        + " 출판일 : " + rs.getString("RELEASE_DATE") + " 상태 : "
                        + rs.getString("RENT_STATE"));
            }
            System.out.println("===============================");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 대출 가능 도서 조회
    @Override
    public void selectPossibleBooks() {
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(
                    "SELECT BID, BNAME, TO_CHAR(RELEASE_DATE, 'YYYY/MM/DD') AS RELEASE_DATE FROM BOOK "
                    + "WHERE RENT_STATE = 'F' ORDER BY RELEASE_DATE DESC");
            System.out.println("======= 대출 가능 도서 =======");
            while (rs.next()) {
                System.out.println("BID : " + rs.getInt("BID") + " 도서명 : " + rs.getString("BNAME")
                        + " 출판일 : " + rs.getString("RELEASE_DATE"));
            }
            System.out.println("===============================");
        } catch (Exception e) {
            e.printStackTrace();
        }
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
