package dao;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Vector;
import java.util.List;
import dal.DBContext;
import model.User;
public class UserDAO {
    final private Connection con;
    final private List<User> users =new Vector<>();

    public UserDAO(Connection con) {
        this.con = con;
    }

    public List<User> getUsers() {
        String sql = "SELECT user_id, full_name, email, username, password, role_id, is_active, create_at FROM users";
        try (
                PreparedStatement stmt = con.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String username = rs.getString("username");
                String password = rs.getString("password");
                int roleId = rs.getInt("role_id");
                boolean isActive = rs.getBoolean("is_active");
                Timestamp ts = rs.getTimestamp("create_at");
                LocalDateTime createAt = null;
                if (ts != null) {
                    createAt = ts.toLocalDateTime();
                }
                users.add(new User(userId, fullName, email, username, password, roleId, isActive, createAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static void main(String[] args) {

        try {
            // Lấy connection từ DBContext
            Connection con = DBContext.getConnection();

            UserDAO dao = new UserDAO(con);
            List<User> users = dao.getUsers();

            // In ra danh sách
            for (User u : users) {
                System.out.println(u.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
