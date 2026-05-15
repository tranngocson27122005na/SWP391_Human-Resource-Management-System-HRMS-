# SWP391_Human-Resource-Management-System-HRMS-
SWP391_GR3_HRMS
Tính năng 1 — Xem danh sách nhân sự

**URL:** `GET /admin/users?action=list`  
**File JSP:** `web/views/admin/user-list.jsp`  
**Controller:** `UserController.doGet()` — case `"list"`

### Mô tả
Hiển thị toàn bộ danh sách nhân sự trong hệ thống dưới dạng bảng.

### Thông tin hiển thị

| Cột | Mô tả |
|-----|-------|
| ID | Mã định danh nội bộ |
| Họ và Tên | Tên đầy đủ của nhân sự |
| Username | Tên tài khoản đăng nhập |
| Email | Địa chỉ email |
| Role ID | Vai trò / phân quyền |
| Trạng thái | `Đang hoạt động` (xanh) / `Bị khóa` (đỏ) |
| Hành động | Nút **Xem** / **Sửa** / **Khóa · Mở khóa** |

Tính năng 2 — Thêm nhân sự mới

**URL:** `GET /admin/users?action=add` (hiển thị form)  
**URL:** `POST /admin/users` (submit form)  
**File JSP:** `web/views/admin/user-form.jsp`  
**Controller:** `UserController.doGet()` — case `"add"` | `UserController.doPost()` — action `"insert"`

### Mô tả
Form nhập thông tin để tạo mới một tài khoản nhân sự trong hệ thống.

### Các trường nhập liệu

| Trường | Bắt buộc | Mô tả |
|--------|----------|-------|
| Họ và Tên | ✅ | Tên đầy đủ |
| Email | ✅ | Địa chỉ email hợp lệ |
| Username | ✅ | Tên đăng nhập |
| Mật khẩu | ✅ | Chỉ hiện khi thêm mới |
| Vai trò (Role) | ✅ | Dropdown từ bảng `roles` |
| Kích hoạt ngay | ☑️ | Checkbox — mặc định checked |

### Quy tắc Validate

**Client-side (JavaScript — realtime):**
- Lỗi hiển thị ngay bên dưới field khi đang gõ
- Chặn submit nếu có field không hợp lệ

**Server-side (Java — lớp bảo vệ thứ 2):**

| Field | Quy tắc |
|-------|---------|
| **Họ và Tên** | Không được để trống · Chỉ chữ cái (kể cả tiếng Việt có dấu), dấu cách, gạch nối · **Không chứa số hoặc ký tự đặc biệt** `(!@#$%^&*...)` |
| **Username** | **Tối thiểu 2 ký tự** · Chỉ chữ cái `a-z A-Z`, số `0-9`, gạch dưới `_` · Không chứa khoảng trắng hoặc ký tự đặc biệt |

> Nếu vi phạm quy tắc validate (kể cả khi JS bị tắt), server sẽ trả form về với thông báo lỗi đỏ và **giữ nguyên dữ liệu đã nhập**.

Tính năng 3 — Xem chi tiết nhân sự

**URL:** `GET /admin/users?action=view&id={userId}`  
**File JSP:** `web/views/admin/user-detail.jsp`  
**Controller:** `UserController.doGet()` — case `"view"`

### Mô tả
Trang hồ sơ chi tiết của một nhân sự, hiển thị đầy đủ thông tin cá nhân và trạng thái tài khoản.

### Thông tin hiển thị

**Banner hồ sơ (gradient):**
- Avatar chữ cái đầu tên (tự động generate)
- Chấm trạng thái: 🟢 Hoạt động / 🔴 Bị khóa
- Họ tên, Role ID, badge mã nhân viên (`EMP0001`)

**Bảng thông tin cơ bản:**

| Trường | Nguồn dữ liệu |
|--------|--------------|
| Họ tên | `user.fullName` |
| Email | `user.email` |
| Mã nhân viên | `EMP` + userId format 4 chữ số |
| Tài khoản (Username) | `user.username` |
| Trạng thái | `user.active` → badge Xanh/Đỏ |
| Role ID | `user.roleId` |

**Các nút hành động:**
- **Chỉnh sửa** → chuyển sang `user-form.jsp` (chế độ Edit)
- **Khóa / Mở khóa tài khoản** → gọi `?action=toggle&id=...`
