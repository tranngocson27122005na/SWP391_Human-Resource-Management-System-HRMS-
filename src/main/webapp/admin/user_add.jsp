<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, model.Role, java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("user");
    Role currentRole = (Role) session.getAttribute("role");
    if (currentUser == null || currentRole == null || !currentRole.getRoleName().equals("ADMIN")) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
        return;
    }
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add User - HRMS</title>
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
            <h1>Add New User</h1>
        </div>

        <div class="card">
            <form action="user-add" method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" name="phone">
                    </div>
                    <div class="form-group">
                        <label>Gender</label>
                        <select name="gender">
                            <option value="MALE">Male</option>
                            <option value="FEMALE">Female</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <select name="roleId">
                            <% if (roles != null) { 
                                for (Role r : roles) { %>
                                <option value="<%= r.getRoleId() %>"><%= r.getRoleName() %></option>
                            <% } } %>
                        </select>
                    </div>
                </div>
                <p style="color: var(--text-muted); font-size: 13px; margin-top: 16px;">Note: Default password will be set to '123456'. Users can change it after first login.</p>
                <div style="margin-top: 32px; text-align: right;">
                    <button type="submit" class="btn btn-primary">Create Account</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
