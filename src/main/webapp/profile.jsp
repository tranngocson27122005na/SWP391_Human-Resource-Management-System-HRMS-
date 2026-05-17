<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, model.Role" %>
<%
    User user = (User) session.getAttribute("user");
    Role role = (Role) session.getAttribute("role");
    if (user == null) { response.sendRedirect("login"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile - HRMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --bg: #0f172a;
            --sidebar-bg: #1e293b;
            --card-bg: #1e293b;
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --border: rgba(255, 255, 255, 0.1);
            --input-bg: #0f172a;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Outfit', sans-serif; }
        body { background: var(--bg); color: var(--text); display: flex; min-height: 100vh; }

        /* Reuse Sidebar Styles */
        .sidebar { width: 280px; background: var(--sidebar-bg); border-right: 1px solid var(--border); padding: 32px 20px; display: flex; flex-direction: column; }
        .logo { display: flex; align-items: center; gap: 12px; font-size: 24px; font-weight: 700; margin-bottom: 48px; color: var(--primary); }
        .nav-group { margin-bottom: 32px; }
        .nav-label { font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted); margin-bottom: 12px; padding-left: 12px; }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--text-muted); text-decoration: none; border-radius: 12px; transition: all 0.3s; margin-bottom: 4px; }
        .nav-item:hover, .nav-item.active { background: rgba(99, 102, 241, 0.1); color: var(--primary); }
        .nav-item i { width: 20px; }

        .main-content { flex: 1; padding: 40px; }
        .profile-container { max-width: 800px; margin: 0 auto; }
        .profile-header { display: flex; align-items: center; gap: 24px; margin-bottom: 40px; }
        .avatar-lg { width: 100px; height: 100px; border-radius: 24px; background: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 40px; font-weight: 700; }

        .card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 24px; padding: 32px; margin-bottom: 24px; }
        .card-title { font-size: 20px; font-weight: 700; margin-bottom: 24px; display: flex; justify-content: space-between; align-items: center; }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-size: 14px; color: var(--text-muted); }
        input, select { width: 100%; padding: 12px 16px; background: var(--input-bg); border: 1px solid var(--border); border-radius: 12px; color: var(--text); outline: none; }
        input:focus { border-color: var(--primary); }

        .btn { padding: 12px 24px; border-radius: 12px; font-weight: 600; cursor: pointer; border: none; transition: all 0.3s; }
        .btn-primary { background: var(--primary); color: white; }
        .btn-primary:hover { opacity: 0.9; transform: translateY(-1px); }

        .alert { padding: 12px 16px; border-radius: 12px; margin-bottom: 24px; font-size: 14px; }
        .alert-success { background: rgba(16, 185, 129, 0.1); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.2); }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo"><i class="fas fa-users-gear"></i> <span>HRMS Portal</span></div>
        <div class="nav-group">
            <div class="nav-label">General</div>
            <a href="home" class="nav-item"><i class="fas fa-home"></i> Dashboard</a>
            <a href="profile" class="nav-item active"><i class="fas fa-user-circle"></i> My Profile</a>
        </div>
        <% if (role != null && role.getRoleName().equals("ADMIN")) { %>
        <div class="nav-group">
            <div class="nav-label">Administration</div>
            <a href="admin/users" class="nav-item"><i class="fas fa-users"></i> User Management</a>
            <a href="admin/roles" class="nav-item"><i class="fas fa-shield-halved"></i> Role Management</a>
        </div>
        <% } %>
        <div class="nav-group" style="margin-top: auto;"><a href="logout" class="nav-item" style="color: #ef4444;"><i class="fas fa-right-from-bracket"></i> Logout</a></div>
    </div>

    <div class="main-content">
        <div class="profile-container">
            <div class="profile-header">
                <div class="avatar-lg"><%= user.getFullName().substring(0,1) %></div>
                <div>
                    <h1 style="font-size: 32px;"><%= user.getFullName() %></h1>
                    <p style="color: var(--text-muted);"><%= role != null ? role.getRoleName() : "Employee" %> • <%= user.getEmail() %></p>
                </div>
            </div>

            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> <%= request.getAttribute("message") %></div>
            <% } %>

            <div class="card">
                <div class="card-title">Personal Information</div>
                <form action="profile" method="POST">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" value="<%= user.getFullName() %>" required>
                        </div>
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" value="<%= user.getUsername() %>" disabled style="opacity: 0.5;">
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" value="<%= user.getEmail() %>" disabled style="opacity: 0.5;">
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <select name="gender">
                                <option value="MALE" <%= "MALE".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="FEMALE" <%= "FEMALE".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="OTHER" <%= "OTHER".equals(user.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                    </div>
                    <div style="margin-top: 24px; text-align: right;">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>

            <div class="card">
                <div class="card-title">
                    Security
                    <a href="change-password" class="btn" style="background: rgba(255,255,255,0.05); color: var(--text); font-size: 14px; text-decoration: none;">Change Password</a>
                </div>
                <p style="color: var(--text-muted); font-size: 14px;">Manage your password and security settings to keep your account safe.</p>
            </div>
        </div>
    </div>
</body>
</html>
