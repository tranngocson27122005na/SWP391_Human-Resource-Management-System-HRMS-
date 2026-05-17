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
    <title>Change Password - HRMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --bg: #0f172a; --sidebar-bg: #1e293b; --card-bg: #1e293b; --text: #f8fafc; --text-muted: #94a3b8; --border: rgba(255, 255, 255, 0.1); --input-bg: #0f172a; --error: #ef4444; }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Outfit', sans-serif; }
        body { background: var(--bg); color: var(--text); display: flex; min-height: 100vh; }
        .sidebar { width: 280px; background: var(--sidebar-bg); border-right: 1px solid var(--border); padding: 32px 20px; display: flex; flex-direction: column; }
        .logo { display: flex; align-items: center; gap: 12px; font-size: 24px; font-weight: 700; margin-bottom: 48px; color: var(--primary); }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--text-muted); text-decoration: none; border-radius: 12px; transition: all 0.3s; margin-bottom: 4px; }
        .nav-item:hover, .nav-item.active { background: rgba(99, 102, 241, 0.1); color: var(--primary); }
        .main-content { flex: 1; padding: 40px; display: flex; align-items: center; justify-content: center; }
        .card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 24px; padding: 40px; width: 100%; max-width: 480px; }
        .card-title { font-size: 24px; font-weight: 700; margin-bottom: 8px; text-align: center; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-size: 14px; color: var(--text-muted); }
        input { width: 100%; padding: 12px 16px; background: var(--input-bg); border: 1px solid var(--border); border-radius: 12px; color: var(--text); outline: none; }
        .btn { width: 100%; padding: 14px; border-radius: 12px; font-weight: 600; cursor: pointer; border: none; background: var(--primary); color: white; margin-top: 16px; }
        .alert { padding: 12px; border-radius: 12px; margin-bottom: 24px; font-size: 14px; text-align: center; }
        .alert-error { background: rgba(239, 68, 68, 0.1); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.2); }
        .alert-success { background: rgba(16, 185, 129, 0.1); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.2); }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo"><i class="fas fa-users-gear"></i> <span>HRMS Portal</span></div>
        <a href="home" class="nav-item"><i class="fas fa-home"></i> Dashboard</a>
        <a href="profile" class="nav-item active"><i class="fas fa-user-circle"></i> My Profile</a>
        <div style="margin-top: auto;"><a href="logout" class="nav-item" style="color: #ef4444;"><i class="fas fa-right-from-bracket"></i> Logout</a></div>
    </div>
    <div class="main-content">
        <div class="card">
            <h1 class="card-title">Change Password</h1>
            <p style="color: var(--text-muted); text-align: center; margin-bottom: 32px; font-size: 14px;">Please enter your current password to confirm the change.</p>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("message") %></div>
            <% } %>

            <form action="change-password" method="POST">
                <div class="form-group">
                    <label>Current Password</label>
                    <input type="password" name="oldPassword" required>
                </div>
                <div class="form-group">
                    <label>New Password</label>
                    <input type="password" name="newPassword" required>
                </div>
                <div class="form-group">
                    <label>Confirm New Password</label>
                    <input type="password" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn">Update Password</button>
            </form>
            <div style="text-align: center; margin-top: 24px;">
                <a href="profile" style="color: var(--text-muted); text-decoration: none; font-size: 14px;">Cancel and go back</a>
            </div>
        </div>
    </div>
</body>
</html>
