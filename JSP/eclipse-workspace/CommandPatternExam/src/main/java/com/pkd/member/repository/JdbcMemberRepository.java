package com.pkd.member.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import com.pkd.member.domain.Member;

public class JdbcMemberRepository implements MemberRepository{

    private DataSource ds;

    public JdbcMemberRepository() {
        // 생성시에 드라이버 등록
        try {
            Context ctx = new InitialContext();
            this.ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle19c");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Member> findAll() {
        List<Member> memberList = new ArrayList<Member>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        final String query = "select * from member";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getString("id"));
                member.setPw(rs.getString("pw"));
                member.setName(rs.getString("name"));
                memberList.add(member);
            }
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
        return memberList;
    }
}
