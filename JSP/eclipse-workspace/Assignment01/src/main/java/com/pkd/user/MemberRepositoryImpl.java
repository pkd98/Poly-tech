package com.pkd.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberRepositoryImpl implements MemberRepository {

    private DataSource ds;

    public MemberRepositoryImpl() {
        // 생성시에 드라이버 등록
        try {
            Context ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle19c");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<MemberDTO> findAll() {
        List<MemberDTO> memberList = new ArrayList<MemberDTO>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        final String query = "select * from user_table";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDTO member = new MemberDTO(rs.getString("id"), rs.getString("pw"),
                        rs.getString("name"), rs.getString("phone"), rs.getString("email"));

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

    @Override
    public int join(MemberDTO member) {
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query =
                "insert into user_table(id, pw, name, phone, email) values(?, ?, ?, ?, ?)";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPw());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getPhone());
            pstmt.setString(5, member.getEmail());
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
    public int withdraw(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int state = 0;

        final String query = "delete from user_table where id = ?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);
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
        MemberDTO member = new MemberDTO();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        final String query = "select * from user_table where id = ?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                member.setId(rs.getString("id"));
                member.setPw(rs.getString("pw"));
                member.setName(rs.getString("name"));
                member.setPhone(rs.getString("phone"));
                member.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return member;
    }

    @Override
    public int updateByMember(MemberDTO member) {
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query = "update user_table set pw = ?, phone = ?, email = ? where id = ?";

        try {
            conn = ds.getConnection();
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
    public int updateByState(String id, int state) {
        int queryState = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query = "update user_table set status = ? where id = ?";
        String status = null;

        switch (state) {
            case 0:
                status = "waiting";
                break;

            case 1:
                status = "normal";
                break;

            case 2:
                status = "pause";
                break;

            default:
                return -1; // 잘못된 접근
        }

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, status);
            pstmt.setString(2, id);
            queryState = pstmt.executeUpdate();

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
        return queryState;
    }

    @Override
    public int updateByRole(String id, boolean isManager) {
        int queryState = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query = "update user_table set role = ? where id = ?";

        String role = (isManager == false) ? "user" : "manager";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, role);
            pstmt.setString(2, id);
            queryState = pstmt.executeUpdate();

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
        return queryState;
    }
}
