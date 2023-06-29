package com.pkd.board.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import com.pkd.board.domain.Board;

public class JdbcBoardRepository implements BoardRepository {

    private DataSource ds;
    private static JdbcBoardRepository instance;

    private JdbcBoardRepository() {
        // 생성시에 JDBC 드라이버 등록
        try {
            Context ctx = new InitialContext();
            this.ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle19c");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static JdbcBoardRepository getInstance() {
        if (instance == null) {
            synchronized (JdbcBoardRepository.class) {
                if (instance == null) {
                    instance = new JdbcBoardRepository();
                }
            }
        }
        return instance;
    }

    @Override
    public List<Board> findAll() {
        List<Board> boardList = new ArrayList<Board>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        final String query = "select * from member";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Board board = new Board();
                board.setId(rs.getInt("id"));
                board.setName(rs.getString("name"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setCreatedAt(rs.getTimestamp("created_at"));
                board.setViews(rs.getInt("views"));
                board.setParentId(rs.getInt("parent_id"));
                board.setDepth(rs.getInt("depth"));

                boardList.add(board);
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
        return boardList;
    }

    @Override
    public List<Board> hierarchicalFindAll() {
        List<Board> boardList = new ArrayList<Board>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        final String query =
                "SELECT * FROM BOARD START WITH PARENT_ID IS NULL CONNECT BY PRIOR ID = PARENT_ID ORDER SIBLINGS BY ID";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Board board = new Board();
                board.setId(rs.getInt("id"));
                board.setName(rs.getString("name"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setCreatedAt(rs.getTimestamp("created_at"));
                board.setViews(rs.getInt("views"));
                board.setParentId(rs.getInt("parent_id"));
                board.setDepth(rs.getInt("depth"));

                boardList.add(board);
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
        return boardList;
    }

    @Override
    public Board findBoardById(int id) {
        // TODO Auto-generated method stub
        Board board = new Board();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        final String query = "SELECT * FROM BOARD WHERE ID = ?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                board.setId(rs.getInt("id"));
                board.setName(rs.getString("name"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setCreatedAt(rs.getTimestamp("created_at"));
                board.setViews(rs.getInt("views"));
                board.setParentId(rs.getInt("parent_id"));
                board.setDepth(rs.getInt("depth"));
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
        return board;
    }

    @Override
    public int insertBoard(Board board) {
        // TODO Auto-generated method stub
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query =
                "INSERT INTO BOARD (ID, NAME, TITLE, CONTENT, VIEWS, PARENT_ID, DEPTH) VALUES (BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            if (board.getParentId() == 0) {
                pstmt.setString(5, null);
            } else {
                pstmt.setInt(5, board.getParentId());
            }
            pstmt.setString(1, board.getName());
            pstmt.setString(2, board.getTitle());
            pstmt.setString(3, board.getContent());
            pstmt.setInt(4, board.getViews());
            pstmt.setInt(6, board.getDepth());
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
    public int updateBoard(Board board) {
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query = "UPDATE BOARD SET TITLE = ?, CONTENT = ? WHERE ID = ?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getContent());
            pstmt.setInt(3, board.getId());
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
    public int updateBoardViews(Board board) {
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query = "UPDATE BOARD SET VIEWS = ? WHERE ID = ?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, board.getViews() + 1);
            pstmt.setInt(2, board.getId());
            state = pstmt.executeUpdate();

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
        return state;

    }

    @Override
    public int deleteBoard(int id) {
        // TODO Auto-generated method stub
        int state = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        final String query = "DELETE FROM BOARD WHERE ID = ?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, id);
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
    public boolean hasRecordById(int id) {
        boolean hasRecord = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        final String query = "SELECT COUNT(*) AS COUNT FROM BOARD WHERE ID = ?";

        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                if (rs.getInt("COUNT") > 0) {
                    hasRecord = true;
                }
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
        return hasRecord;
    }
}
