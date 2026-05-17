package controller;

import dao.RoleDAO;
import dao.PermissionDAO;
import model.Role;
import model.Permission;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/roles", "/admin/role-permissions", "/admin/role-update", "/admin/role-status", "/admin/role-edit-permissions"})
public class RoleManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Role currentRole = (session != null) ? (Role) session.getAttribute("role") : null;
        
        if (currentRole == null || !currentRole.getRoleName().equals("ADMIN")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        RoleDAO roleDAO = new RoleDAO();
        PermissionDAO permDAO = new PermissionDAO();
        String path = request.getServletPath();

        if (path.equals("/admin/roles")) {
            List<Role> roleList = roleDAO.getAllRoles();
            request.setAttribute("roleList", roleList);
            request.getRequestDispatcher("/admin/role_list.jsp").forward(request, response);
        } else if (path.equals("/admin/role-permissions")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Role role = roleDAO.getRoleById(id);
            List<Permission> rolePermissions = roleDAO.getRolePermissions(id);
            List<Permission> allPermissions = permDAO.getAllPermissions();
            
            request.setAttribute("role", role);
            request.setAttribute("rolePermissions", rolePermissions);
            request.setAttribute("allPermissions", allPermissions);
            request.getRequestDispatcher("/admin/role_permissions.jsp").forward(request, response);
        } else if (path.equals("/admin/role-status")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            roleDAO.updateStatus(id, status);
            response.sendRedirect("roles");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Role currentRole = (session != null) ? (Role) session.getAttribute("role") : null;
        
        if (currentRole == null || !currentRole.getRoleName().equals("ADMIN")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        RoleDAO roleDAO = new RoleDAO();
        String path = request.getServletPath();

        if (path.equals("/admin/role-update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Role role = roleDAO.getRoleById(id);
            role.setRoleName(request.getParameter("roleName"));
            role.setDescription(request.getParameter("description"));
            role.setStatus(request.getParameter("status"));
            
            if (roleDAO.updateRole(role)) {
                response.sendRedirect("roles");
            } else {
                request.setAttribute("error", "Failed to update role.");
                request.getRequestDispatcher("/admin/role_list.jsp").forward(request, response);
            }
        } else if (path.equals("/admin/role-edit-permissions")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String[] permissionIds = request.getParameterValues("permissionIds");
            
            if (roleDAO.updateRolePermissions(id, permissionIds)) {
                response.sendRedirect("role-permissions?id=" + id);
            } else {
                request.setAttribute("error", "Failed to update permissions.");
                response.sendRedirect("role-permissions?id=" + id);
            }
        }
    }
}
