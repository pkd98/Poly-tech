package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class JdbcMemberRepository implements MemberRepository {

    final String DB_URL = "jdbc:oracle:thin:@localhost:1521/da2308";
    final String DB_USER = "scott";
    final String DB_PASSWORD = "tiger";


    @Override
    public void save(Member member) {
        // TODO Auto-generated method stub
        final String sql = "insert into member(id, pw, name, email) values(?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPw());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getEmail());

            pstmt.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                pstmt.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            try {
                conn.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<Member> selectAll() {
        // TODO Auto-generated method stub
        List<Member> memberList = new ArrayList<Member>();
        final String sql = "select * from member";
        ResultSet selectAllResultSet = null;

        Connection conn = null;
        Statement stmt = null;


        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = conn.createStatement();
            selectAllResultSet = stmt.executeQuery(sql);

            while (selectAllResultSet.next()) {
                Member member = new Member();

                member.setId(selectAllResultSet.getString("ID"));
                member.setPw(selectAllResultSet.getString("PW"));
                member.setName(selectAllResultSet.getString("NAME"));
                member.setEmail(selectAllResultSet.getString("EMAIL"));

                memberList.add(member);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                stmt.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            try {
                conn.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return memberList;
    }
}
