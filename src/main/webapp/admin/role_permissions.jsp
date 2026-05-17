<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, model.Role, model.Permission, java.util.List, java.util.Set, java.util.stream.Collectors" %>
<%
    User currentUser = (User) session.getAttribute("user");
    Role currentRole = (Role) session.getAttribute("role");
    if (currentUser == null || currentRole == null || !currentRole.getRoleName().equals("ADMIN")) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
        return;
    }
    Role role = (Role) request.getAttribute("role");
    List<Permission> rolePermissions = (List<Permission>) request.getAttribute("rolePermissions");
    List<Permission> allPermissions = (List<Permission>) request.getAttribute("allPermissions");
    
    Set<Integer> rolePermissionIds = rolePermissions.stream()
            .map(Permission::getPermissionId)
            .collect(Collectors.toSet());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Role Permissions - HRMS</title>
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
        .card { background: var(--card-bg); border: 1px solid var(--border); border-radius: 24px; padding: 32px; }
        
        .perm-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 16px; margin-top: 24px; }
        .perm-item { background: rgba(255,255,255,0.02); border: 1px solid var(--border); padding: 16px; border-radius: 12px; display: flex; align-items: flex-start; gap: 12px; cursor: pointer; transition: all 0.3s; }
        .perm-item:hover { border-color: var(--primary); background: rgba(99, 102, 241, 0.05); }
        .perm-item input { margin-top: 4px; }
        
        .btn { padding: 12px 24px; border-radius: 12px; font-weight: 600; cursor: pointer; border: none; transition: all 0.3s; }
        .btn-primary { background: var(--primary); color: white; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo" style="display: flex; align-items: center; gap: 12px; font-size: 24px; font-weight: 700; margin-bottom: 48px; color: var(--primary);"><i class="fas fa-users-gear"></i> <span>HRMS</span></div>
        <a href="../home" class="nav-item"><i class="fas fa-home"></i> Dashboard</a>
        <a href="roles" class="nav-item active"><i class="fas fa-shield-halved"></i> Role Management</a>
    </div>
    <div class="main-content">
        <div style="margin-bottom: 32px; display: flex; align-items: center; gap: 16px;">
            <a href="roles" style="color: var(--text-muted);"><i class="fas fa-arrow-left"></i></a>
            <h1>Manage Permissions: <%= role.getRoleName() %></h1>
        </div>

        <div class="card">
            <form action="role-edit-permissions" method="POST">
                <input type="hidden" name="id" value="<%= role.getRoleId() %>">
                <p style="color: var(--text-muted); font-size: 14px;">Select the permissions this role should have across the system modules.</p>
                
                <div class="perm-grid">
                    <% if (allPermissions != null) { 
                        for (Permission p : allPermissions) { %>
                    <label class="perm-item">
                        <input type="checkbox" name="permissionIds" value="<%= p.getPermissionId() %>" 
                            <%= rolePermissionIds.contains(p.getPermissionId()) ? "checked" : "" %>>
                        <div>
                            <div style="font-weight: 600; font-size: 15px;"><%= p.getPermissionName() %></div>
                            <div style="font-size: 12px; color: var(--text-muted); margin-top: 4px;"><%= p.getModuleName() %></div>
                        </div>
                    </label>
                    <% } } %>
                </div>
                
                <div style="margin-top: 40px; text-align: right;">
                    <button type="submit" class="btn btn-primary">Save Permissions</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
