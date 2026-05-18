package dao;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Vector;
import java.util.List;
import dal.DBContext;
import model.User;
public class UserDAO {
    final private Connection con;
    private List<User> users;

    public UserDAO() {
        con = DBContext.getConnection();
    }
    public List<User> getUsers() {
        users =new Vector<>();
        String sql = "SELECT user_id, full_name, email, username, password, role_id, is_active, create_at FROM users";
        try (
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

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
            UserDAO dao = new UserDAO();
            List<User> users = dao.getUsers();
            for (User u : users) {
                System.out.println(u.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // 8 & 11. Lấy thông tin 1 User theo ID
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("user_id"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setRoleId(rs.getInt("role_id"));
                    u.setActive(rs.getBoolean("is_active"));
                    return u;
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi getUserById: " + e.getMessage());
        }
        return null;
    }

    // 9. Add new user (Thêm người dùng mới)
    public void insertUser(User u) {
        String sql = "INSERT INTO users (full_name, email, username, password, role_id, is_active, create_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, u.getFullName());
            st.setString(2, u.getEmail());
            st.setString(3, u.getUsername());
            st.setString(4, u.getPassword());
            st.setInt(5, u.getRoleId());
            st.setBoolean(6, u.isActive());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi insertUser: " + e.getMessage());
        }
    }
}
