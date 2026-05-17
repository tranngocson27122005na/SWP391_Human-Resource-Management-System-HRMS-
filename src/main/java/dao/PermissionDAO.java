package dao;

import dal.DBContext;
import model.Permission;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PermissionDAO {

    public List<Permission> getAllPermissions() {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT * FROM permissions";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(new Permission(
                    rs.getInt("permission_id"),
                    rs.getString("permission_name"),
                    rs.getString("permission_code"),
                    rs.getString("module_name"),
                    rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
