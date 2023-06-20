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
    final static String DB_URL = "jdbc:oracle:thin:@192.168.119.119:1521:dink08";
    final static String DB_USER = "c##scott";
    final static String DB_PASSWORD = "tiger";

    // // 태근의 Oracle DBMS
    // final static String DB_URL = "jdbc:oracle:thin:@49.247.25.122:1521:xe";
    // final static String DB_USER = "scott";
    // final static String DB_PASSWORD = "tiger";

    // Oracle 클라우드
    // final static String DB_URL =
    // "jdbc:oracle:thin:@dinkdb_medium?TNS_ADMIN=D:/database/oracleCloud/Wallet_DinkDB";
    // final static String DB_USER = "DA2308";
    // final static String DB_PASSWORD = "Data2308";

    // SQL Query
    final static String selectEmployee = "SELECT * FROM EMP";
    final static String selectCustomer = "SELECT MGR_EMPNO FROM CUSTOMER";
    final static String insertBonus =
            "INSERT INTO BONUS (ENAME, JOB, SAL, COMM) VALUES (?, ?, ?, ?)";

    // 변수 초기화
    ResultSet employeeResultSet = null;
    ResultSet customerResultSet = null;
    boolean processState = false;
    int offset = 10;
    int process = 0;
    // 직원별 담당 고객 수를 저장하기 위한 HashMap
    Map<Integer, Integer> countCustomerMap = new HashMap<Integer, Integer>();
    // EMPNO별 EMP 객체 저장 (BONUS 테이블에 Insert 용도)
    Map<Integer, EMP> empMap = new HashMap<Integer, EMP>();

    Repository() {
        // try-with-resources 이용 자동 close() 호출
        // DBMS 접속 및 Statement, PreparedStatement 객체 정의
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                Statement stmt = conn.createStatement();
                Statement stmtCustomer = conn.createStatement();
                PreparedStatement pstmt2 = conn.prepareStatement(insertBonus)) {
            
            stmt.setFetchSize(offset);
            stmtCustomer.setFetchSize(offset);
            pstmt2.setFetchSize(offset);
            
            System.out.println("Fetch Size : " + stmtCustomer.getFetchSize());

            // EMP 테이블 조회 쿼리 실행
            employeeResultSet = stmt.executeQuery(selectEmployee);
            
            // EMP 객체 생성, HashMap 초기화
            while (employeeResultSet.next()) {
                int EMPNO = employeeResultSet.getInt("EMPNO");
                String ENAME = employeeResultSet.getString("ENAME");
                String JOB = employeeResultSet.getString("JOB");
                int SAL = employeeResultSet.getInt("SAL");

                EMP emp = new EMP(EMPNO, ENAME, JOB, SAL);

                countCustomerMap.put(EMPNO, 0); // 담당 customer 0 초기화
                empMap.put(EMPNO, emp); // 사번별 EMP 객체 저장
            }
            employeeResultSet.close();

            // CUSTOMER 테이블 조회 쿼리 실행
            customerResultSet = stmtCustomer.executeQuery(selectCustomer);
            System.out.println("처리중..");

            // 결과 처리
            while (customerResultSet.next()) {
                if (process % 100000 == 0) {
                    System.out.println(process + " 진행중..");
                }
                processState = true;
                int MGR_EMPNO = customerResultSet.getInt("MGR_EMPNO");
                countCustomerMap.put(MGR_EMPNO, countCustomerMap.get(MGR_EMPNO) + 1);
                process += 1;
            }
            System.out.println(process + " - 처리 완료");
            customerResultSet.close();

            // 보너스 계산 및 Insert
            // Iterator를 사용하여 조회
            Iterator<Map.Entry<Integer, Integer>> iter = countCustomerMap.entrySet().iterator();

            while (iter.hasNext()) {
                Map.Entry<Integer, Integer> entry = iter.next();
                int key = entry.getKey();
                int value = entry.getValue();
                String ename = empMap.get(key).ENAME;
                String job = empMap.get(key).JOB;
                int sal = empMap.get(key).SAL;

                pstmt2.setString(1, ename); // ENAME
                pstmt2.setString(2, job); // JOB
                pstmt2.setInt(3, sal); // SAL

                // 직업이 PRESIDENT 또는 ANALYST는 보너스 X
                if (job.equals("PRESIDENT") || job.equals("ANALYST")) {
                    pstmt2.setInt(4, 0); // COMM
                } else {
                    // 10만 이하 고객 관리 사원 보너스 1000 지급
                    if (value <= 100000) {
                        pstmt2.setInt(4, 1000); // COMM
                    } else { // 10만 초과 고객 관리 사원 보너스 1000 지급
                        pstmt2.setInt(4, 2000); // COMM
                    }
                }
                pstmt2.executeUpdate();
            }
            System.out.println("Bonus Insert 완료!");
        } catch (SQLException e) {
            System.out.println("Error executing SQL statement: " + e.getMessage());
        }
    }
}
