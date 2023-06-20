import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Repository {
    // 내 Docker 기반 Oracle DBMS
     final static String DB_URL = "jdbc:oracle:thin:@192.168.119.119:1521:dink08";
     final static String DB_USER = "c##scott";
     final static String DB_PASSWORD = "tiger";

    // // 태근의 Oracle DBMS
    // final static String DB_URL = "jdbc:oracle:thin:@49.247.25.122:1521:xe";
    // final static String DB_USER = "scott";
    // final static String DB_PASSWORD = "tiger";

    // Oracle 클라우드
//    final static String DB_URL =
//            "jdbc:oracle:thin:@dinkdb_medium?TNS_ADMIN=D:/database/oracleCloud/Wallet_DinkDB";
//    final static String DB_USER = "DA2308";
//    final static String DB_PASSWORD = "Data2308";

    // SQL Query
    final static String sql = "INSERT INTO Bonus (ENAME, JOB, SAL, COMM)\r\n"
            + "SELECT E.ENAME, E.JOB, E.SAL,\r\n"
            + "    CASE \r\n"
            + "        WHEN E.JOB IN ('PRESIDENT', 'ANALYST') THEN 0\r\n"
            + "        WHEN C.CNT > 100000 THEN 2000\r\n"
            + "        ELSE 1000\r\n"
            + "    END\r\n"
            + "FROM EMP E\r\n"
            + "LEFT OUTER JOIN\r\n"
            + "    (SELECT MGR_EMPNO, COUNT(MGR_EMPNO) AS CNT \r\n"
            + "     FROM CUSTOMER \r\n"
            + "     GROUP BY MGR_EMPNO\r\n"
            + "    ) C\r\n"
            + "ON E.EMPNO = C.MGR_EMPNO";


    Repository() {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                PreparedStatement pstmt = conn.prepareStatement(sql);) {

            // PreparedStatement PL/SQL 쿼리 실행
            System.out.println("실행중..");
            pstmt.execute();
            System.out.println("처리 완료");
            
        } catch (SQLException e) {
            System.out.println("Error executing SQL statement: " + e.getMessage());
        }
    }
}
