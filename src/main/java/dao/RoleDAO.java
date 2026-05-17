package dao;

import dal.DBContext;
import model.Role;
import model.Permission;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {

    public List<Role> getAllRoles() {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM roles";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(new Role(
                    rs.getInt("role_id"),
                    rs.getString("role_name"),
                    rs.getString("description"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Role getRoleById(int id) {
        String sql = "SELECT * FROM roles WHERE role_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
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

    public boolean updateRole(Role role) {
        String sql = "UPDATE roles SET role_name = ?, description = ?, status = ? WHERE role_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, role.getRoleName());
            st.setString(2, role.getDescription());
            st.setString(3, role.getStatus());
            st.setInt(4, role.getRoleId());
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int roleId, String status) {
        String sql = "UPDATE roles SET status = ? WHERE role_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, status);
            st.setInt(2, roleId);
            return st.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Permission> getRolePermissions(int roleId) {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT p.* FROM permissions p JOIN role_permissions rp ON p.permission_id = rp.permission_id WHERE rp.role_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, roleId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    list.add(new Permission(
                        rs.getInt("permission_id"),
                        rs.getString("permission_name"),
                        rs.getString("permission_code"),
                        rs.getString("module_name"),
                        rs.getString("description")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateRolePermissions(int roleId, String[] permissionIds) {
        String sqlDelete = "DELETE FROM role_permissions WHERE role_id = ?";
        String sqlInsert = "INSERT INTO role_permissions (role_id, permission_id) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement st1 = conn.prepareStatement(sqlDelete)) {
                st1.setInt(1, roleId);
                st1.executeUpdate();
            }
            if (permissionIds != null) {
                try (PreparedStatement st2 = conn.prepareStatement(sqlInsert)) {
                    for (String pId : permissionIds) {
                        st2.setInt(1, roleId);
                        st2.setInt(2, Integer.parseInt(pId));
                        st2.addBatch();
                    }
                    st2.executeBatch();
                }
            }
            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
