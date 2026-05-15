<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${user != null ? 'Cập nhật' : 'Thêm mới'} Người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .invalid-feedback { display: none; }
        .is-invalid ~ .invalid-feedback { display: block; }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">${user != null ? 'Cập nhật thông tin User' : 'Thêm Người dùng mới'}</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>
                    <form id="userForm" action="${pageContext.request.contextPath}/admin/users"
                          method="POST" onsubmit="return validateForm()">

                        <!-- Bắt buộc: Truyền action để doPost biết phải làm gì -->
                        <input type="hidden" name="action" value="${user != null ? 'update' : 'insert'}">

                        <div class="mb-3">
                            <label class="form-label" for="fullName">Họ và Tên (*)</label>
                            <input type="text" id="fullName" name="fullName" class="form-control"
                                   required value="${user.fullName}"
                                   oninput="validateFullName()">
                            <div class="invalid-feedback" id="fullName-error"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email (*)</label>
                            <input type="email" name="email" class="form-control" required value="${user.email}">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label" for="username">Tài khoản (Username)</label>
                                <input type="text" id="username" name="username" class="form-control"
                                       value="${user.username}"
                                ${user != null ? 'readonly' : 'required'}
                                       oninput="validateUsername()">
                                <div class="invalid-feedback" id="username-error"></div>
                                <small class="text-muted">${user != null ? 'Không thể thay đổi Username sau khi tạo.' : 'Tối thiểu 2 kí tự, chỉ dùng chữ/số/gạch dưới.'}</small>
                            </div>

                            <!-- Chỉ hiện ô Password khi Thêm mới -->
                            <c:if test="${user == null}">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Mật khẩu (*)</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                            </c:if>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Vai trò (Role)</label>
                                <select name="roleId" class="form-select">
                                    <c:forEach var="r" items="${listRoles}">
                                        <option value="${r.roleId}" ${user != null && user.roleId == r.roleId ? 'selected' : ''}>
                                                ${r.roleName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <c:if test="${user == null}">
                                <div class="col-md-6 mb-3 d-flex align-items-end">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="isActive" id="isActive" checked>
                                        <label class="form-check-label" for="isActive">
                                            Kích hoạt tài khoản ngay lập tức
                                        </label>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <a href="${pageContext.request.contextPath}/admin/users?action=list" class="btn btn-secondary me-2">Hủy bỏ</a>
                            <button type="submit" class="btn btn-primary">
                                ${user != null ? 'Lưu thay đổi' : 'Tạo tài khoản'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // === QUY Tắc VALIDATE ===
    // Họ tên: chỉ cho phép chữ cái (bao gồm tiếng Việt), dấu cách và dấu gạch nối
    const NAME_REGEX = /^[\p{L}\s\-]+$/u;
    // Username: chỉ chữ/số/gạch dưới, tối thiểu 2 kí tự
    const USERNAME_REGEX = /^[a-zA-Z0-9_]{2,}$/;

    function setError(inputId, errorId, message) {
        const input = document.getElementById(inputId);
        const error = document.getElementById(errorId);
        if (message) {
            input.classList.add('is-invalid');
            input.classList.remove('is-valid');
            error.textContent = message;
        } else {
            input.classList.remove('is-invalid');
            input.classList.add('is-valid');
            error.textContent = '';
        }
    }

    function validateFullName() {
        const val = document.getElementById('fullName').value.trim();
        if (val.length === 0) {
            setError('fullName', 'fullName-error', 'Họ tên không được để trống.');
            return false;
        }
        if (!NAME_REGEX.test(val)) {
            setError('fullName', 'fullName-error', 'Họ tên không được chứa số hoặc kí tự đặc biệt (!@#$...).');
            return false;
        }
        setError('fullName', 'fullName-error', '');
        return true;
    }

    function validateUsername() {
        const input = document.getElementById('username');
        // Bỏ qua nếu đang ở chế độ readonly (trang Edit)
        if (input.readOnly) return true;
        const val = input.value.trim();
        if (val.length === 0) {
            setError('username', 'username-error', 'Username không được để trống.');
            return false;
        }
        if (val.length < 2) {
            setError('username', 'username-error', 'Username phải có ít nhất 2 kí tự.');
            return false;
        }
        if (!USERNAME_REGEX.test(val)) {
            setError('username', 'username-error', 'Username chỉ được chứa chữ cái, số và gạch dưới (_). Không được có kí tự đặc biệt.');
            return false;
        }
        setError('username', 'username-error', '');
        return true;
    }

    function validateForm() {
        const fullNameOk = validateFullName();
        const usernameOk = validateUsername();
        // Trả về false để chặn submit nếu có lỗi
        return fullNameOk && usernameOk;
    }
</script>
</body>
</html>
