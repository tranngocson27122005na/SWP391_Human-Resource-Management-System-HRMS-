package dao;
import java.sql.*;
import java.util.Vector;
import java.util.List;
import dal.DBContext;
import model.Permission;

public class PermissionDAO {
    final private Connection con;
    final private List<Permission> permissions= new Vector<>();

    public PermissionDAO() {
        con = DBContext.getConnection() ;
    }

    public List<Permission> getPermissions() {
        String sql = "SELECT * FROM permissions";
        try (
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("permission_id");
                String name = rs.getString("permission_name");
                String desc = rs.getString("description");
                permissions.add(new Permission(id, name, desc));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return permissions;
    }
    public static void main(String[] args) {
        try {
            PermissionDAO dao = new PermissionDAO();
            List<Permission> permissions = dao.getPermissions();
            for (Permission p : permissions) {
                System.out.println(p.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
