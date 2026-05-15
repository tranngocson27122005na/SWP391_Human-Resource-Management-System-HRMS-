package dao;
import java.sql.*;
import java.util.Vector;
import java.util.List;
import dal.DBContext;
import model.Role;
public class RoleDAO {
    final private Connection con;
    final private List<Role> roles= new Vector<>();

    public RoleDAO(Connection con) {
        this.con = con;
    }
    public List<Role> getRoles() {
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

    public static void main(String[] args) {
        try {
            // Lấy connection từ DBContext
            Connection conn = DBContext.getConnection();

            // Khởi tạo RoleDAO với connection
            RoleDAO roleDAO = new RoleDAO(conn);

            // Gọi LoadRoles
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
