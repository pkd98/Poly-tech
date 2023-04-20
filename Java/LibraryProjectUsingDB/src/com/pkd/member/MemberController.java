package com.pkd.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import com.pkd.utils.MemberUtil;
import com.pkd.utils.Utils;

public class MemberController implements MemberUtil {
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet deleteTempResultSet = null;
    ResultSet rs = null;
    Connection conn = Utils.getOracleConnect();


    public MemberController() {}

    // 회원 등록
    @Override
    public void register(String mName, String Address, String phoneNumber, String Birthday) {
        try {
            pstmt = conn.prepareStatement(
                    "INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY)"
                            + "VALUES(MEMBER_SEQ.NEXTVAL, ?, ?, ?, ?)");

            pstmt.setString(1, mName);
            pstmt.setString(2, Address);
            pstmt.setString(3, phoneNumber);
            pstmt.setString(4, Birthday);
            System.out.println(mName + Address + phoneNumber + Birthday);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("회원 등록 실패!");
            return;
        }
        System.out.println("정상 등록 되었습니다.");
    }

    // 회원 수정
    @Override
    public void modify(int mId, String mName, String address, String phoneNumber, String birthday) {
        try {
            pstmt = conn.prepareStatement(
                    "UPDATE MEMBER SET MNAME = ?, ADDRESS = ?, PHONE_NUMBER = ?, BIRTHDAY = ? WHERE MID = ?");
            pstmt.setString(1, mName);
            pstmt.setString(2, address);
            pstmt.setString(3, phoneNumber);
            pstmt.setString(4, birthday);
            pstmt.setInt(5, mId);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("회원 수정 실패!");
            return;
        }
        System.out.println("정상 수정 되었습니다.");
    }

    // 회원 삭제
    @Override
    public void remove(int ID) {
        try {
            // Undo를 위한 삭제 대상 데이터 임시 저장
            stmt = conn.createStatement();
            deleteTempResultSet = stmt.executeQuery(
                    "SELECT MID, MNAME, ADDRESS, PHONE_NUMBER, TO_CHAR(BIRTHDAY, 'YYYY/MM/DD') AS BIRTHDAY FROM MEMBER WHERE MID = "
                            + ID);

            // 해당 회원 삭제
            pstmt = conn.prepareStatement("DELETE FROM MEMBER WHERE MID = ?");
            pstmt.setInt(1, ID);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("회원 삭제 실패!");
            return;
        }
        System.out.println("정상 삭제 되었습니다.");
    }

    // 회원 삭제 취소
    @Override
    public void undo() {
        try {
            // 복구는 한번만 가능
            if (deleteTempResultSet == null) {
                System.out.println("복구할 회원이 없습니다.");
                return;
            }
            int mid = 0;
            String mName = "";
            String address = "";
            String phoneNumber = "";
            String birthday = "";

            while (deleteTempResultSet.next()) {
                mid = deleteTempResultSet.getInt("MID");
                mName = deleteTempResultSet.getString("MNAME");
                address = deleteTempResultSet.getString("ADDRESS");
                phoneNumber = deleteTempResultSet.getString("PHONE_NUMBER");
                birthday = deleteTempResultSet.getString("BIRTHDAY");
            }

            pstmt = conn.prepareStatement(
                    "INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY) VALUES(?, ?, ?, ?, ?)");
            pstmt.setInt(1, mid);
            pstmt.setString(2, mName);
            pstmt.setString(3, address);
            pstmt.setString(4, phoneNumber);
            pstmt.setString(5, birthday);
            pstmt.executeUpdate();
            commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("회원 삭제 복구 실패!");
            return;
        }
        deleteTempResultSet = null;
        System.out.println("정상 삭제 복구 되었습니다.");
    }

    // 모든 회원 조회
    @Override
    public void selectAll() {
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(
                    "SELECT MID, MNAME, TO_CHAR(SIGN_UP_DATE, 'YYYY/MM/DD') AS SIGN_UP_DATE,"
                            + " to_number(to_char(sysdate, 'yyyy')) - to_number(to_char(birthday, 'yyyy')) + 1 || '세' AS AGE,"
                            + " ADDRESS, PHONE_NUMBER, TO_CHAR(BIRTHDAY, 'YYYY/MM/DD') AS BIRTHDAY "
                            + " FROM MEMBER ORDER BY MID");

            System.out.println("=================== 회원 정보 ===================");
            while (rs.next()) {
                System.out.println("MID : " + rs.getInt("MID") + " 이름 : " + rs.getString("MNAME")
                        + " 가입일 : " + rs.getString("SIGN_UP_DATE") + " 나이 : " + rs.getString("AGE")
                        + "\n" + " 주소 : " + rs.getString("ADDRESS") + " 연락처 : "
                        + rs.getString("PHONE_NUMBER") + " 생일 : " + rs.getString("BIRTHDAY")
                        + "\n");
            }
            System.out.println("=================================================");
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
