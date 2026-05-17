package controller;

import dao.UserDAO;
import dao.RoleDAO;
import model.User;
import model.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/users", "/admin/user-detail", "/admin/user-add", "/admin/user-status", "/admin/user-update"})
public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Role currentRole = (session != null) ? (Role) session.getAttribute("role") : null;
        
        if (currentRole == null || !currentRole.getRoleName().equals("ADMIN")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        UserDAO userDAO = new UserDAO();
        RoleDAO roleDAO = new RoleDAO();
        String path = request.getServletPath();

        if (path.equals("/admin/users")) {
            List<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("/admin/user_list.jsp").forward(request, response);
        } else if (path.equals("/admin/user-detail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.getUserById(id);
            Role role = userDAO.getUserRole(id);
            request.setAttribute("u", user);
            request.setAttribute("uRole", role);
            request.getRequestDispatcher("/admin/user_detail.jsp").forward(request, response);
        } else if (path.equals("/admin/user-add")) {
            List<Role> roles = roleDAO.getAllRoles();
            request.setAttribute("roles", roles);
            request.getRequestDispatcher("/admin/user_add.jsp").forward(request, response);
        } else if (path.equals("/admin/user-status")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            userDAO.updateStatus(id, status);
            response.sendRedirect("users");
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

        UserDAO userDAO = new UserDAO();
        String path = request.getServletPath();

        if (path.equals("/admin/user-add")) {
            User newUser = new User();
            newUser.setUsername(request.getParameter("username"));
            newUser.setEmail(request.getParameter("email"));
            newUser.setPassword("123456"); // Default password
            newUser.setFullName(request.getParameter("fullName"));
            newUser.setPhone(request.getParameter("phone"));
            newUser.setGender(request.getParameter("gender"));
            newUser.setStatus("ACTIVE");
            
            if (userDAO.addUser(newUser)) {
                // Get the user back to set the role
                User added = userDAO.login(newUser.getUsername(), newUser.getPassword());
                if (added != null) {
                    int roleId = Integer.parseInt(request.getParameter("roleId"));
                    userDAO.setUserRole(added.getUserId(), roleId);
                }
                response.sendRedirect("users");
            } else {
                request.setAttribute("error", "Failed to add user.");
                request.getRequestDispatcher("/admin/user_add.jsp").forward(request, response);
            }
        } else if (path.equals("/admin/user-update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.getUserById(id);
            user.setFullName(request.getParameter("fullName"));
            user.setPhone(request.getParameter("phone"));
            user.setGender(request.getParameter("gender"));
            user.setStatus(request.getParameter("status"));
            
            if (userDAO.updateUser(user)) {
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                userDAO.setUserRole(id, roleId);
                response.sendRedirect("users");
            } else {
                request.setAttribute("error", "Failed to update user.");
                request.getRequestDispatcher("/admin/user_detail.jsp").forward(request, response);
            }
        }
    }
}
