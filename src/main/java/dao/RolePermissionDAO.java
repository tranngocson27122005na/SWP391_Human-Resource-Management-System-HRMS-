package dao;

import dal.DBContext;
import model. Permission;
import java.sql.*;

import java.sql.Connection;

import java.util.List;
import java.util.Vector;

public class RolePermissionDAO {
    final private Connection con;
    public RolePermissionDAO() {
        con = DBContext.getConnection();
    }
    public List<Permission> getPermissionsByRole(int roleId) {
        List<Permission> list = new Vector<>();
        String sql = "SELECT p.permission_id, p.permission_name, p.description " +
                "FROM roles_permissions rp " +
                "JOIN permissions p ON rp.permission_id = p.permission_id " +
                "WHERE rp.role_id = ?";
        try (
            PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Permission(
                        rs.getInt("permission_id"),
                        rs.getString("permission_name"),
                        rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Xóa một quyền khỏi role
    public void deleteRolePermission(int roleId, int permissionId) {
        String sql = "DELETE FROM roles_permissions WHERE role_id=? AND permission_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ps.setInt(2, permissionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    // thêm quyền cho role
    public void insertRolePermission(int roleId, int permissionId) {
        String sql = "INSERT INTO roles_permissions(role_id, permission_id) VALUES (?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ps.setInt(2, permissionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        try {
            RolePermissionDAO dao = new RolePermissionDAO();
            // Lấy quyền của role admin (id=1)
            List<Permission> permissions = dao.getPermissionsByRole(1);
            for (Permission p : permissions) {
                System.out.println(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
