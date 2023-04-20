package application;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.pkd.utils.Utils;

public class testInsert {

    public static void main(String[] args) {

        Connection conn = Utils.getOracleConnect();
        PreparedStatement pstmt = null;

        try {
            pstmt = conn.prepareStatement(
                    "INSERT INTO MEMBER(MID, MNAME, ADDRESS, PHONE_NUMBER, BIRTHDAY)"
                            + "VALUES(MEMBER_SEQ.NEXTVAL, ?, ?, ?, ?)");
            String a = "박박박";
            String b = "서울시 구로구";
            String c = "01055551231";
            String d = "1999/01/01";

            pstmt.setString(1, a);
            pstmt.setString(2, b);
            pstmt.setString(3, c);
            pstmt.setString(4, d);

            int result = pstmt.executeUpdate();
            System.out.println("성공");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
