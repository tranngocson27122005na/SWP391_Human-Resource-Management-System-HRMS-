package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtils {
    
    // Change these to match your local MySQL configuration
    private static final String URL = "jdbc:mysql://localhost:3306/Week1";
    private static final String USER = "root";
    private static final String PASSWORD = "root"; // Update with your MySQL password

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, USER, PASSWORD);
        return conn;
    }
}
