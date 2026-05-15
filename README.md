# 📋 User Management — Quản lý Nhân sự

Hệ thống quản lý nhân sự xây dựng bằng **Java Servlet + JSP + JSTL** theo mô hình **MVC**.

## ✨ Tính năng 1 — Xem danh sách nhân sự

**URL:** `GET /admin/users?action=list`  
**JSP:** `user-list.jsp`  
**DAO:** `UserDAO.getAllUsers()`

### Hiển thị

Bảng danh sách toàn bộ nhân sự trong hệ thống:

| Cột | Mô tả |
|-----|-------|
| ID | Mã định danh |
| Họ và Tên | Tên đầy đủ |
| Username | Tên tài khoản |
| Email | Địa chỉ email |
| Role ID | Vai trò |
| Trạng thái | `Đang hoạt động` / `Bị khóa` |
| Hành động | Nút **Xem chi tiết** — Nút **Thêm mới** |

### Luồng xử lý

```
GET /admin/users?action=list
        ↓
UserController.doGet() — case "list"
        ↓
UserDAO.getAllUsers()
  SELECT * FROM users
        ↓
setAttribute("listUsers", list)
        ↓
forward → user-list.jsp
```

---

## ✨ Tính năng 2 — Xem thông tin chi tiết nhân sự

**URL:** `GET /admin/users?action=view&id={userId}`  
**JSP:** `user-detail.jsp`  
**DAO:** `UserDAO.getUserById(id)`

### Hiển thị

**Banner hồ sơ:**
- Avatar chữ cái đầu tên (tự generate)
- Chấm trạng thái: 🟢 Hoạt động / 🔴 Bị khóa
- Họ tên, mã nhân viên `EMP0001`

**Bảng thông tin chi tiết:**

| Trường | Dữ liệu |
|--------|---------|
| Họ và Tên | `user.fullName` |
| Email | `user.email` |
| Mã nhân viên | `EMP` + userId (4 chữ số) |
| Tài khoản | `user.username` |
| Trạng thái | Badge xanh / đỏ |
| Role ID | `user.roleId` |

### Luồng xử lý

```
GET /admin/users?action=view&id=1
        ↓
UserController.doGet() — case "view"
        ↓
UserDAO.getUserById(1)
  SELECT * FROM users WHERE user_id = ?
  ├─ null  → HTTP 404 Not Found
  └─ found → setAttribute("user", viewUser)
        ↓
forward → user-detail.jsp
```

---

## ✨ Tính năng 3 — Thêm nhân sự mới

**URL hiển thị form:** `GET /admin/users?action=add`  
**URL submit:** `POST /admin/users` (hidden field `action=insert`)  
**JSP:** `user-form.jsp`  
**DAO:** `UserDAO.insertUser()` | `RoleDAO.getAllRoles()`

### Các trường nhập liệu

| Trường | Bắt buộc | Ghi chú |
|--------|----------|---------|
| Họ và Tên | ✅ | Có validate |
| Email | ✅ | Kiểu `type="email"` |
| Username | ✅ | Có validate |
| Mật khẩu | ✅ | |
| Vai trò (Role) | ✅ | Dropdown từ bảng `roles` |
| Kích hoạt ngay | — | Checkbox, mặc định ✔ |

### Quy tắc Validate

Áp dụng **2 lớp** — client-side (JS realtime) và server-side (Java):

| Field | Quy tắc |
|-------|---------|
| **Họ và Tên** | Không để trống · Chỉ chữ cái (gồm tiếng Việt có dấu), dấu cách, gạch nối · **Không chứa số hoặc ký tự đặc biệt** |
| **Username** | **Tối thiểu 2 ký tự** · Chỉ `a-z`, `A-Z`, `0-9`, `_` · Không khoảng trắng, không ký tự đặc biệt |

**Client-side:** Lỗi hiện ngay dưới field khi đang gõ, chặn submit nếu không hợp lệ.  
**Server-side:** Nếu JS bị tắt hoặc request giả mạo — server validate lại, trả form về kèm thông báo lỗi đỏ và **giữ nguyên dữ liệu đã nhập**.

### Luồng xử lý

```
GET /admin/users?action=add
        ↓
UserController.doGet() — case "add"
        ↓
RoleDAO.getAllRoles()  →  setAttribute("listRoles", ...)
        ↓
forward → user-form.jsp  (chế độ: Thêm mới)
        ↓
[Người dùng điền form → nhấn "Tạo tài khoản"]
        ↓
POST /admin/users  (action=insert)
        ↓
Server-side Validate
  ├─ Lỗi → forward lại user-form.jsp + hiện errorMessage
  └─ Hợp lệ → UserDAO.insertUser(newUser)
              INSERT INTO users (...) VALUES (...)
        ↓
redirect → /admin/users?action=list
```

---

## ⚙️ Cài đặt & Chạy

**Yêu cầu:** Java 17+ · Jakarta EE 10 · Tomcat 10.x · MySQL

**Cấu hình DB** — sửa `web/WEB-INF/ConnectDB.properties`:
```properties
url=jdbc:mysql://localhost:3306/your_database
username=root
password=your_password
```

**Chạy:** Clean & Build → Deploy lên Tomcat → truy cập `/login`
