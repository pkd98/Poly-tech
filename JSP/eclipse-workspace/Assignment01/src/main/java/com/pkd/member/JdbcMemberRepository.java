package com.pkd.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JdbcMemberRepository implements MemberRepository {

    private final String DB_URL = "jdbc:oracle:thin:@localhost:1521/da2308";
    private final String DB_ID = "scott";
    private final String DB_PW = "tiger";

    public JdbcMemberRepository() {
        // 생성시에 드라이버 등록
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<MemberDTO> findAll() {
        List<MemberDTO> memberList = new ArrayList<MemberDTO>();


        return memberList;
    }

    @Override
    public int updateByMember(MemberDTO member) {
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query = "update member set pw = ?, name = ?, email = ? where id = ?";

        try {
            conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, member.getPw());
            pstmt.setString(2, member.getName());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getId());
            state = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
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
        return state;
    }

    @Override
    public int join(MemberDTO member) {
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query =
                "insert into member(name, id, pw, email, gender) values(?, ?, ?, ?, ?)";

        try {
            conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getId());
            pstmt.setString(3, member.getPw());
            pstmt.setString(4, member.getEmail());
            pstmt.setString(5, member.getGender());
            state = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
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
        return state;
    }

    @Override
    public MemberDTO findByMember(String id) {
        MemberDTO member = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        final String query = "select * from member where id = ?";

        try {
            conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            member = new MemberDTO(rs.getString("name"), rs.getString("id"), rs.getString("pw"),
                    rs.getString("email"), rs.getString("gender"));

        } catch (Exception e) {
            e.printStackTrace();
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
        return member;
    }
}
