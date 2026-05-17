<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, model.Role" %>
<%
    User user = (User) session.getAttribute("user");
    Role role = (Role) session.getAttribute("role");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - HRMS</title>
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
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Outfit', sans-serif; }
        body { background: var(--bg); color: var(--text); display: flex; min-height: 100vh; }

        .sidebar {
            width: 280px;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--border);
            padding: 32px 20px;
            display: flex;
            flex-direction: column;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 48px;
            color: var(--primary);
        }

        .nav-group { margin-bottom: 32px; }
        .nav-label {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
            margin-bottom: 12px;
            padding-left: 12px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            color: var(--text-muted);
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s;
            margin-bottom: 4px;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary);
        }

        .nav-item i { width: 20px; }

        .main-content {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }

        .welcome-card {
            background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            padding: 40px;
            border-radius: 24px;
            margin-bottom: 32px;
            position: relative;
            overflow: hidden;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 24px;
            border-radius: 20px;
            border: 1px solid var(--border);
        }

        .stat-val { font-size: 28px; font-weight: 700; margin: 8px 0; }
        .stat-label { color: var(--text-muted); font-size: 14px; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <i class="fas fa-users-gear"></i>
            <span>HRMS Portal</span>
        </div>

        <div class="nav-group">
            <div class="nav-label">General</div>
            <a href="home" class="nav-item active"><i class="fas fa-home"></i> Dashboard</a>
            <a href="profile" class="nav-item"><i class="fas fa-user-circle"></i> My Profile</a>
        </div>

        <% if (role != null && role.getRoleName().equals("ADMIN")) { %>
        <div class="nav-group">
            <div class="nav-label">Administration</div>
            <a href="admin/users" class="nav-item"><i class="fas fa-users"></i> User Management</a>
            <a href="admin/roles" class="nav-item"><i class="fas fa-shield-halved"></i> Role Management</a>
        </div>
        <% } %>

        <div class="nav-group" style="margin-top: auto;">
            <a href="logout" class="nav-item" style="color: #ef4444;"><i class="fas fa-right-from-bracket"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <h1>Dashboard</h1>
            <div class="user-profile">
                <div class="user-info text-right" style="text-align: right;">
                    <div style="font-weight: 600;"><%= user.getFullName() %></div>
                    <div style="font-size: 12px; color: var(--text-muted);"><%= role != null ? role.getRoleName() : "No Role" %></div>
                </div>
                <div class="avatar"><%= user.getFullName().substring(0,1) %></div>
            </div>
        </div>

        <div class="welcome-card">
            <h2 style="font-size: 32px; margin-bottom: 8px;">Welcome back, <%= user.getFullName().split(" ")[0] %>!</h2>
            <p style="opacity: 0.9;">You have full access to the HR management system. Check your latest updates here.</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Total Employees</div>
                <div class="stat-val">124</div>
                <div style="color: #10b981; font-size: 12px;"><i class="fas fa-arrow-up"></i> 12% from last month</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Active Users</div>
                <div class="stat-val">89</div>
                <div style="color: #10b981; font-size: 12px;"><i class="fas fa-circle"></i> Currently online</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Pending Roles</div>
                <div class="stat-val">3</div>
                <div style="color: #f59e0b; font-size: 12px;"><i class="fas fa-clock"></i> Requires attention</div>
            </div>
        </div>
    </div>
</body>
</html>
