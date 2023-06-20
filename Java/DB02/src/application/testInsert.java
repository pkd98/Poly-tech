package application;

import java.sql.*;

public class testInsert {
    final static String DB_URL= "jdbc:oracle:thin:@dinkdb_medium?TNS_ADMIN=D:/database/oracleCloud/Wallet_DinkDB";
    final static String DB_USER = "DA2308";
    final static String DB_PASSWORD = "Data2308";

    public static void main(String[] args) {

        Connection conn = null;

        try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch(ClassNotFoundException e){
                e.printStackTrace();
                System.out.println("드라이버 로딩 실패");
        }
        try{
                String jdbcUrl = "jdbc:oracle:thin:@192.168.119.119:1521:dink08";
                String userId = "c##scott";
                String userPass = "tiger";
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                System.out.println("Oracle DBMS 접속 성공!!!");
        }catch(SQLException e){
                System.out.println("Connection 설정 실패");
                System.out.println(e.getMessage());
                e.printStackTrace();
        }
    }
}