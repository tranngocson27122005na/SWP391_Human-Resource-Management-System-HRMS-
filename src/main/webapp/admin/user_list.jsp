<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, model.Role, java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("user");
    Role currentRole = (Role) session.getAttribute("role");
    if (currentUser == null || currentRole == null || !currentRole.getRoleName().equals("ADMIN")) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
        return;
    }
    List<User> userList = (List<User>) request.getAttribute("userList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management - HRMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --bg: #0f172a; --sidebar-bg: #1e293b; --card-bg: #1e293b; --text: #f8fafc; --text-muted: #94a3b8; --border: rgba(255, 255, 255, 0.1); }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Outfit', sans-serif; }
        body { background: var(--bg); color: var(--text); display: flex; min-height: 100vh; }
        .sidebar { width: 280px; background: var(--sidebar-bg); border-right: 1px solid var(--border); padding: 32px 20px; display: flex; flex-direction: column; }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--text-muted); text-decoration: none; border-radius: 12px; transition: all 0.3s; margin-bottom: 4px; }
        .nav-item.active { background: rgba(99, 102, 241, 0.1); color: var(--primary); }
        .main-content { flex: 1; padding: 40px; }
        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
        .btn { padding: 10px 20px; border-radius: 10px; font-weight: 600; cursor: pointer; border: none; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; font-size: 14px; }
        .btn-primary { background: var(--primary); color: white; }
        
        .table-container { background: var(--card-bg); border: 1px solid var(--border); border-radius: 20px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 16px 24px; background: rgba(255,255,255,0.02); color: var(--text-muted); font-size: 13px; text-transform: uppercase; letter-spacing: 1px; }
        td { padding: 16px 24px; border-top: 1px solid var(--border); font-size: 15px; }
        tr:hover td { background: rgba(255,255,255,0.01); }
        
        .status-badge { padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-active { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .status-inactive { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
        
        .action-btn { color: var(--text-muted); transition: color 0.3s; margin-right: 12px; }
        .action-btn:hover { color: var(--primary); }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo" style="display: flex; align-items: center; gap: 12px; font-size: 24px; font-weight: 700; margin-bottom: 48px; color: var(--primary);"><i class="fas fa-users-gear"></i> <span>HRMS</span></div>
        <a href="../home" class="nav-item"><i class="fas fa-home"></i> Dashboard</a>
        <a href="../profile" class="nav-item"><i class="fas fa-user-circle"></i> My Profile</a>
        <div style="height: 1px; background: var(--border); margin: 20px 0;"></div>
        <a href="users" class="nav-item active"><i class="fas fa-users"></i> User Management</a>
        <a href="roles" class="nav-item"><i class="fas fa-shield-halved"></i> Role Management</a>
        <div style="margin-top: auto;"><a href="../logout" class="nav-item" style="color: #ef4444;"><i class="fas fa-right-from-bracket"></i> Logout</a></div>
    </div>
    <div class="main-content">
        <div class="header-actions">
            <h1>User Management</h1>
            <a href="user-add" class="btn btn-primary"><i class="fas fa-plus"></i> Add New User</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Email</th>
                        <th>Gender</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (userList != null) { 
                        for (User u : userList) { %>
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center; gap: 12px;">
                                <div style="width: 32px; height: 32px; border-radius: 8px; background: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: 700;"><%= u.getFullName().substring(0,1) %></div>
                                <div>
                                    <div style="font-weight: 600;"><%= u.getFullName() %></div>
                                    <div style="font-size: 12px; color: var(--text-muted);">@<%= u.getUsername() %></div>
                                </div>
                            </div>
                        </td>
                        <td><%= u.getEmail() %></td>
                        <td><%= u.getGender() %></td>
                        <td>
                            <span class="status-badge <%= u.getStatus().equals("ACTIVE") ? "status-active" : "status-inactive" %>">
                                <%= u.getStatus() %>
                            </span>
                        </td>
                        <td>
                            <a href="user-detail?id=<%= u.getUserId() %>" class="action-btn" title="View/Edit"><i class="fas fa-edit"></i></a>
                            <% if (u.getStatus().equals("ACTIVE")) { %>
                                <a href="user-status?id=<%= u.getUserId() %>&status=INACTIVE" class="action-btn" title="Deactivate" style="color: #ef4444;"><i class="fas fa-user-slash"></i></a>
                            <% } else { %>
                                <a href="user-status?id=<%= u.getUserId() %>&status=ACTIVE" class="action-btn" title="Activate" style="color: #10b981;"><i class="fas fa-user-check"></i></a>
                            <% } %>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
