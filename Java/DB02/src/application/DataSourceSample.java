package application;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.pool.OracleDataSource;

public class DataSourceSample {
    // The recommended format of a connection URL is the long format with the
    // connection descriptor.

    final static String DB_URL =
            "jdbc:oracle:thin:@dinkdb_medium?TNS_ADMIN=D:/database/oracleCloud/Wallet_DinkDB";
    final static String DB_USER = "DA2308";
    final static String DB_PASSWORD = "Data2308";

    /*
     * The method gets a database connection using oracle.jdbc.pool.OracleDataSource. It also sets
     * some connection level properties, such as,
     * OracleConnection.CONNECTION_PROPERTY_DEFAULT_ROW_PREFETCH,
     * OracleConnection.CONNECTION_PROPERTY_THIN_NET_CHECKSUM_TYPES, etc., There are many other
     * connection related properties. Refer to the OracleConnection interface to find more.
     */
    public static void main(String args[]) throws SQLException {
        Properties info = new Properties();
        info.put(OracleConnection.CONNECTION_PROPERTY_USER_NAME, DB_USER);
        info.put(OracleConnection.CONNECTION_PROPERTY_PASSWORD, DB_PASSWORD);
        info.put(OracleConnection.CONNECTION_PROPERTY_DEFAULT_ROW_PREFETCH, "20");


        OracleDataSource ods = new OracleDataSource();
        ods.setURL(DB_URL);
        ods.setConnectionProperties(info);

        // With AutoCloseable, the connection is closed automatically.
        try (OracleConnection connection = (OracleConnection) ods.getConnection()) {
            // Get the JDBC driver name and version
            DatabaseMetaData dbmd = connection.getMetaData();
            System.out.println("Driver Name: " + dbmd.getDriverName());
            System.out.println("Driver Version: " + dbmd.getDriverVersion());
            // Print some connection properties
            System.out.println(
                    "Default Row Prefetch Value is: " + connection.getDefaultRowPrefetch());
            System.out.println("Database Username is: " + connection.getUserName());
            System.out.println();
            // Perform a database operation
            printEmployees(connection);
        }
    }

    /*
     * Displays first_name and last_name from the employees table.
     */
    public static void printEmployees(Connection connection) throws SQLException {
        // Statement and ResultSet are AutoCloseable and closed automatically.
        try (Statement statement = connection.createStatement()) {
            try (ResultSet resultSet =
                    statement.executeQuery("select first_name, last_name from employees")) {
                System.out.println("FIRST_NAME" + "  " + "LAST_NAME");
                System.out.println("---------------------");
                while (resultSet.next())
                    System.out.println(resultSet.getString(1) + " " + resultSet.getString(2) + " ");
            }
        }
    }
}

