package com.pkd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class test {

    public static void main(String[] args) {
        
        String name, id, pw, email, gender;
        String query;
        Connection conn;
        Statement stmt;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/da2308", "scott",
                    "tiger");
            stmt = conn.createStatement();
            System.out.println("성공");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
