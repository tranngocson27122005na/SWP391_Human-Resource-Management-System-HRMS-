package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/profile", "/change-password"})
public class ProfileServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        if (path.equals("/profile")) {
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if (path.equals("/change-password")) {
            request.getRequestDispatcher("change_password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        UserDAO dao = new UserDAO();
        String path = request.getServletPath();

        if (path.equals("/profile")) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setGender(gender);
            
            if (dao.updateUser(user)) {
                session.setAttribute("user", user);
                request.setAttribute("message", "Profile updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update profile.");
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            
        } else if (path.equals("/change-password")) {
            String oldPass = request.getParameter("oldPassword");
            String newPass = request.getParameter("newPassword");
            String confirmPass = request.getParameter("confirmPassword");
            
            if (!user.getPassword().equals(oldPass)) {
                request.setAttribute("error", "Incorrect old password.");
            } else if (!newPass.equals(confirmPass)) {
                request.setAttribute("error", "Passwords do not match.");
            } else {
                if (dao.changePassword(user.getUserId(), newPass)) {
                    user.setPassword(newPass);
                    session.setAttribute("user", user);
                    request.setAttribute("message", "Password changed successfully!");
                } else {
                    request.setAttribute("error", "Failed to change password.");
                }
            }
            request.getRequestDispatcher("change_password.jsp").forward(request, response);
        }
    }
}
