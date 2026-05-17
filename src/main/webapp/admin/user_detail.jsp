<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, model.Role, java.util.List, dao.RoleDAO" %>
<%
    User currentUser = (User) session.getAttribute("user");
    Role currentRole = (Role) session.getAttribute("role");
    if (currentUser == null || currentRole == null || !currentRole.getRoleName().equals("ADMIN")) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
        return;
    }
    User u = (User) request.getAttribute("u");
    Role uRole = (Role) request.getAttribute("uRole");
    RoleDAO roleDAO = new RoleDAO();
    List<Role> roles = roleDAO.getAllRoles();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Detail - HRMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --bg: #0f172a; --sidebar-bg: #1e293b; --card-bg: #1e293b; --text: #f8fafc; --text-muted: #94a3b8; --border: rgba(255, 255, 255, 0.1); --input-bg: #0f172a; }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Outfit', sans-serif; }
        body { background: var(--bg); color: var(--text); display: flex; min-height: 100vh; }
        .sidebar { width: 280px; background: var(--sidebar-bg); border-right: 1px solid var(--border); padding: 32px 20px; display: flex; flex-direction: column; }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--text-muted); text-decoration: none; border-radius: 12px; transition: all 0.3s; margin-bottom: 4px; }
        .nav-item.active { background: rgba(99, 102, 241, 0.1); color: var(--primary); }
        .main-content { flex: 1; padding: 40px; }
        .card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 24px; padding: 32px; max-width: 800px; margin: 0 auto; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-size: 14px; color: var(--text-muted); }
        input, select { width: 100%; padding: 12px 16px; background: var(--input-bg); border: 1px solid var(--border); border-radius: 12px; color: var(--text); outline: none; }
        .btn { padding: 12px 24px; border-radius: 12px; font-weight: 600; cursor: pointer; border: none; transition: all 0.3s; }
        .btn-primary { background: var(--primary); color: white; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo" style="display: flex; align-items: center; gap: 12px; font-size: 24px; font-weight: 700; margin-bottom: 48px; color: var(--primary);"><i class="fas fa-users-gear"></i> <span>HRMS</span></div>
        <a href="../home" class="nav-item"><i class="fas fa-home"></i> Dashboard</a>
        <a href="users" class="nav-item active"><i class="fas fa-users"></i> User Management</a>
        <a href="roles" class="nav-item"><i class="fas fa-shield-halved"></i> Role Management</a>
    </div>
    <div class="main-content">
        <div style="margin-bottom: 32px; display: flex; align-items: center; gap: 16px;">
            <a href="users" style="color: var(--text-muted);"><i class="fas fa-arrow-left"></i></a>
            <h1>User Information</h1>
        </div>

        <div class="card">
            <form action="user-update" method="POST">
                <input type="hidden" name="id" value="<%= u.getUserId() %>">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" value="<%= u.getUsername() %>" disabled style="opacity: 0.5;">
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" value="<%= u.getEmail() %>" disabled style="opacity: 0.5;">
                    </div>
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="fullName" value="<%= u.getFullName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" name="phone" value="<%= u.getPhone() != null ? u.getPhone() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Gender</label>
                        <select name="gender">
                            <option value="MALE" <%= "MALE".equals(u.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="FEMALE" <%= "FEMALE".equals(u.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="OTHER" <%= "OTHER".equals(u.getGender()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <select name="roleId">
                            <% for (Role r : roles) { %>
                                <option value="<%= r.getRoleId() %>" <%= (uRole != null && uRole.getRoleId() == r.getRoleId()) ? "selected" : "" %>><%= r.getRoleName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <select name="status">
                            <option value="ACTIVE" <%= "ACTIVE".equals(u.getStatus()) ? "selected" : "" %>>Active</option>
                            <option value="INACTIVE" <%= "INACTIVE".equals(u.getStatus()) ? "selected" : "" %>>Inactive</option>
                        </select>
                    </div>
                </div>
                <div style="margin-top: 32px; text-align: right;">
                    <button type="submit" class="btn btn-primary">Update User</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
