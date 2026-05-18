package controller.admin;

import dao.RoleDAO;
import dao.RolePermissionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Role;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/roles")
public class RoleController extends HttpServlet {
    private RoleDAO roleDAO;
    private RolePermissionDAO rpDAO;
    public void init(){
        roleDAO = new RoleDAO();
        rpDAO = new RolePermissionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Role> roles = roleDAO.getRoles();
        req.setAttribute("roles", roles);
        req.getRequestDispatcher("/view/admin/list-roles.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Role> roles = roleDAO.getRoles();
        for (Role r : roles) {
            String param = req.getParameter("active_" + r.getRoleId());
            if (param != null) {
                boolean newActive = Boolean.parseBoolean(param);
                roleDAO.updateRoleActive(r.getRoleId(), newActive);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/roles");
    }
}
