package dao;

import dal.DBContext;
import model.User;
import model.Role;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User login(String usernameOrEmail, String password) {
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ? AND status = 'ACTIVE'";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, usernameOrEmail);
            st.setString(2, usernameOrEmail);
            st.setString(3, password);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, email, password, full_name, phone, gender, avatar_url, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, user.getUsername());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPassword());
            st.setString(4, user.getFullName());
            st.setString(5, user.getPhone());
            st.setString(6, user.getGender());
            st.setString(7, user.getAvatarUrl());
            st.setString(8, user.getStatus());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, gender = ?, avatar_url = ?, status = ? WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, user.getFullName());
            st.setString(2, user.getPhone());
            st.setString(3, user.getGender());
            st.setString(4, user.getAvatarUrl());
            st.setString(5, user.getStatus());
            st.setInt(6, user.getUserId());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, status);
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, newPassword);
            st.setInt(2, userId);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Role getUserRole(int userId) {
        String sql = "SELECT r.* FROM roles r JOIN user_roles ur ON r.role_id = ur.role_id WHERE ur.user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Role(
                        rs.getInt("role_id"),
                        rs.getString("role_name"),
                        rs.getString("description"),
                        rs.getString("status")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean setUserRole(int userId, int roleId) {
        String sqlDelete = "DELETE FROM user_roles WHERE user_id = ?";
        String sqlInsert = "INSERT INTO user_roles (user_id, role_id) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement st1 = conn.prepareStatement(sqlDelete)) {
                st1.setInt(1, userId);
                st1.executeUpdate();
            }
            try (PreparedStatement st2 = conn.prepareStatement(sqlInsert)) {
                st2.setInt(1, userId);
                st2.setInt(2, roleId);
                st2.executeUpdate();
            }
            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("user_id"),
            rs.getString("username"),
            rs.getString("email"),
            rs.getString("password"),
            rs.getString("full_name"),
            rs.getString("phone"),
            rs.getString("gender"),
            rs.getString("avatar_url"),
            rs.getString("status"),
            rs.getTimestamp("created_at"),
            rs.getTimestamp("updated_at")
        );
    }
}
