package dao;
import java.sql.*;
import java.util.Vector;
import java.util.List;
import dal.DBContext;
import model.Role;
public class RoleDAO {
    private final Connection con;
    private List<Role> roles;

    public RoleDAO() {
        con = DBContext.getConnection();
    }
    public List<Role> getRoles() {
        roles= new Vector<>();
        String sql = "SELECT * FROM roles";
        try (
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
            int id =rs.getInt("role_id");
            String name=rs.getString("role_name");
            boolean active =rs.getBoolean("is_active");
            roles.add(new Role(id,name, active));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }
    //update roles
    public void updateRoleActive(int roleId, boolean active) {
        String sql = "UPDATE roles SET is_active=? WHERE role_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, active);
            ps.setInt(2, roleId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        try {
            RoleDAO roleDAO = new RoleDAO();
            List<Role> roles = roleDAO.getRoles();
            // In kết quả
            for (Role r : roles) {
                System.out.println(r.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
