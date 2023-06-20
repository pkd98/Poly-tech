import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Repository {
    // 내 Docker 기반 Oracle DBMS
//    final static String DB_URL = "jdbc:oracle:thin:@192.168.119.119:1521:dink08";
//    final static String DB_USER = "c##scott";
//    final static String DB_PASSWORD = "tiger";

    // // 태근의 Oracle DBMS
    // final static String DB_URL = "jdbc:oracle:thin:@49.247.25.122:1521:xe";
    // final static String DB_USER = "scott";
    // final static String DB_PASSWORD = "tiger";

    // Oracle 클라우드
     final static String DB_URL =
     "jdbc:oracle:thin:@dinkdb_medium?TNS_ADMIN=D:/database/oracleCloud/Wallet_DinkDB";
     final static String DB_USER = "DA2308";
     final static String DB_PASSWORD = "Data2308";

    // SQL Query
    final static String plsql = "{call insert_bonus_primitive}";

    // 변수 초기화
    ResultSet plsqlResultSet = null;
    boolean processState = false;
    int process = 0;

    Repository() {
        // try-with-resources 이용 자동 close() 호출
        // DBMS 접속 및 Statement, PreparedStatement 객체 정의
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                CallableStatement cstmt = conn.prepareCall(plsql);) {
                        
            // CallableStatement PL/SQL 쿼리 실행
            System.out.println("실행중..");
            cstmt.execute();
            System.out.println("처리 완료");
            cstmt.close();
            
        } catch (SQLException e) {
            System.out.println("Error executing SQL statement: " + e.getMessage());
        }
    }
}
