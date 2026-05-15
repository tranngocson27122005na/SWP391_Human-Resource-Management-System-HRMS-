<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ nhân sự - ${user.fullName}</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fc;
        }

        /* Topbar Header */
        .top-header {
            background-color: #0b3a82;
            color: white;
            padding: 10px 20px;
            display: flex;
            align-items: center;
        }
        .top-header .close-btn {
            color: white;
            text-decoration: none;
            font-size: 20px;
            margin-right: 15px;
        }

        /* Navigation Tabs */
        .nav-tabs-wrapper {
            background: white;
            border-bottom: 1px solid #e3e6f0;
            padding: 0 20px;
        }
        .nav-tabs-custom {
            display: flex;
            gap: 2rem;
            margin: 0;
            padding: 0;
            list-style: none;
        }
        .nav-tabs-custom li a {
            display: block;
            padding: 15px 10px;
            color: #6c757d;
            text-decoration: none;
            font-weight: 500;
            border-bottom: 3px solid transparent;
        }
        .nav-tabs-custom li a.active {
            color: #0056b3;
            border-bottom-color: #0056b3;
            font-weight: 600;
        }

        /* Gradient Banner */
        .profile-banner {
            background: linear-gradient(135deg, #747dff 0%, #3e48db 100%);
            border-radius: 8px;
            padding: 40px;
            color: white;
            display: flex;
            align-items: center;
            margin: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .avatar-large {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid rgba(255, 255, 255, 0.4);
            background-color: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            font-weight: 700;
            position: relative;
            margin-right: 30px;
        }

        .status-dot-large {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 20px;
            height: 20px;
            background-color: #27ae60;
            border: 3px solid #747dff;
            border-radius: 50%;
        }

        .status-dot-offline {
            background-color: #e74c3c;
        }

        /* Information Card */
        .info-card {
            background: white;
            border-radius: 8px;
            margin: 0 20px 20px 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            border: 1px solid #e3e6f0;
        }
        .info-card-header {
            padding: 20px 25px;
            border-bottom: 1px solid #e3e6f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .info-card-body {
            padding: 30px 25px;
        }
        .info-label {
            color: #6c757d;
            font-weight: 500;
            width: 140px;
            flex-shrink: 0;
        }
        .info-value {
            color: #333;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <div class="top-header">
        <a href="${pageContext.request.contextPath}/admin/users?action=list" class="close-btn"><i class="fa-solid fa-xmark"></i></a>
        <span>Nhân sự &nbsp;&nbsp;&gt;&nbsp;&nbsp; ${user.fullName}</span>
    </div>

    <div class="nav-tabs-wrapper">
        <ul class="nav-tabs-custom">
            <li><a href="#" class="active">Thông tin</a></li>
            <li><a href="#">Năng lực</a></li>
            <li><a href="#">Kỹ năng</a></li>
            <li><a href="#">Thăng tiến</a></li>
            <li><a href="#">Đào tạo</a></li>
            <li><a href="#">Dòng thời gian</a></li>
            <li><a href="#">Tài khoản</a></li>
        </ul>
    </div>

    <div class="profile-banner">
        <div class="avatar-large">
            <c:if test="${not empty user.fullName}">${fn:toUpperCase(fn:substring(user.fullName, 0, 1))}</c:if>
            
            <c:choose>
                <c:when test="${user.active}">
                    <div class="status-dot-large"></div>
                </c:when>
                <c:otherwise>
                    <div class="status-dot-large status-dot-offline"></div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div>
            <h1 class="fw-bold mb-2" style="font-size: 32px;">${user.fullName}</h1>
            <p class="mb-1"><i class="fa-solid fa-sitemap fa-sm me-2"></i> Role ID: ${user.roleId} (Chưa gán chức danh chi tiết)</p>
            <p class="mb-3"><i class="fa-regular fa-building fa-sm me-2"></i> Chưa gán đơn vị</p>
            
            <div class="d-flex gap-2 mt-2">
                <c:choose>
                    <c:when test="${user.active}">
                        <span class="badge rounded-pill bg-light text-primary px-3 py-2">Hoạt động</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge rounded-pill bg-light text-danger px-3 py-2">Bị khóa</span>
                    </c:otherwise>
                </c:choose>
                <span class="badge rounded-pill bg-dark bg-opacity-25 px-3 py-2 border border-light border-opacity-25">EMP<fmt:formatNumber value="${user.userId}" pattern="0000"/></span>
            </div>
        </div>
    </div>

    <div class="info-card">
        <div class="info-card-header">
            <h5 class="mb-0 fw-bold">Thông tin cơ bản</h5>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.userId}" class="btn btn-sm btn-outline-primary px-3">
                    <i class="fa-regular fa-pen-to-square me-1"></i> Chỉnh sửa
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?action=toggle&id=${user.userId}&status=${user.active}" class="btn btn-sm btn-outline-danger px-3" onclick="return confirm('Bạn có chắc muốn đổi trạng thái user này?');">
                    ${user.active ? 'Khóa tài khoản' : 'Mở khóa'}
                </a>
            </div>
        </div>
        
        <div class="info-card-body">
            <div class="row gy-4">
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Họ tên:</div>
                    <div class="info-value">${user.fullName}</div>
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Chức danh:</div>
                    <div class="info-value text-muted">—</div>
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Email:</div>
                    <div class="info-value">${user.email}</div>
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Đơn vị:</div>
                    <div class="info-value text-muted">—</div>
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Mã nhân viên:</div>
                    <div class="info-value">EMP<fmt:formatNumber value="${user.userId}" pattern="0000"/></div>
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Trạng thái:</div>
                    <div class="info-value">
                        <c:choose>
                            <c:when test="${user.active}">
                                <span class="badge bg-success px-2 py-1">Hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger px-2 py-1">Đã khóa</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Tài khoản (Username):</div>
                    <div class="info-value">${user.username}</div>
                </div>
                <div class="col-md-6 d-flex align-items-center">
                    <div class="info-label">Role ID:</div>
                    <div class="info-value text-muted">${user.roleId}</div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
