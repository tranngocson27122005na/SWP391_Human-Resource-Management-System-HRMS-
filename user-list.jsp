<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Danh sách Người dùng</h2>
            <!-- Nút Add chuyển sang trang form -->
            <a href="${pageContext.request.contextPath}/admin/users?action=add" class="btn btn-success">+ Thêm nhân sự mới</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Họ và Tên</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role ID</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${listUsers}">
                            <tr>
                                <td>${u.userId}</td>
                                <td><strong>${u.fullName}</strong></td>
                                <td>${u.username}</td>
                                <td>${u.email}</td>
                                <td><span class="badge bg-secondary">Role: ${u.roleId}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <span class="badge bg-success">Đang hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Bị khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- Nút Xem chi tiết -->
                                    <a href="${pageContext.request.contextPath}/admin/users?action=view&id=${u.userId}" class="btn btn-sm btn-info text-white">Xem</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
