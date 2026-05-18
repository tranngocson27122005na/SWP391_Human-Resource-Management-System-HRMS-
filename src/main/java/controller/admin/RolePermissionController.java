package controller.admin;

import dao.RoleDAO;
import dao.RolePermissionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Permission;
import model.Role;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/role-permissions")
public class RolePermissionController extends HttpServlet {
    private RoleDAO roleDAO;
    private RolePermissionDAO rpDAO;
    public void init(){
        roleDAO = new RoleDAO();
        rpDAO = new RolePermissionDAO();
    }
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Role> roles = roleDAO.getRoles();
        for (Role r : roles) {
            List<Permission> perms = rpDAO.getPermissionsByRole(r.getRoleId());
            req.setAttribute("permissions_" + r.getRoleId(), perms);
        }
        req.setAttribute("roles", roles);
        req.getRequestDispatcher("/view/admin/list-permissions-roles.jsp").forward(req, resp);

    }
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int roleId = Integer.parseInt(req.getParameter("roleId"));
            int permissionId = Integer.parseInt(req.getParameter("permissionId"));
            rpDAO.insertRolePermission(roleId, permissionId);
            resp.sendRedirect(req.getContextPath() + "/admin/role-permissions");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
        }
    }
}
