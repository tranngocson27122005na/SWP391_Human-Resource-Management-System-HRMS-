package dal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBContext {
    private static final String URL = "jdbc:mysql://localhost:3306/week1?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Kết nối thành công tới database!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ Không tìm thấy MySQL Driver: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("❌ Lỗi kết nối database: " + e.getMessage());
        }
        return connection;
    }

    public static void main(String[] args) {
        Connection conn = DBContext.getConnection();
    }
}