package com.pkd.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Utils {
    // Oracle JDBC 드라이버 객체
    private static Connection conn = null;

    private Utils() {} // 생성자 private

    public static Connection getOracleConnect() {
        if (conn == null) { // 처음 null 이면 연결
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                String url = "jdbc:oracle:thin:@192.168.119.119:1521/dink";
                String user = "scott";
                String passwd = "tiger";
                conn = DriverManager.getConnection(url, user, passwd);
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
        return conn; // 싱글턴 객체 리턴
    }

    public static void connectionClose() {
        if (conn != null) { // Connection이 null이 아닐때만 close
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            conn = null;
        }
    }
}
