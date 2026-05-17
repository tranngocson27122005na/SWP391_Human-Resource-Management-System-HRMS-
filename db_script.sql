-- =====================================================
-- DATABASE: SWP391_HRMS
-- =====================================================

DROP DATABASE IF EXISTS Week1;
CREATE DATABASE Week1
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE Week1;

-- =====================================================
-- 1. USERS
-- =====================================================

CREATE TABLE users (
    user_id             INT AUTO_INCREMENT PRIMARY KEY,
    username            VARCHAR(50) NOT NULL UNIQUE,
    email               VARCHAR(100) NOT NULL UNIQUE,
    password_hash       VARCHAR(255) NOT NULL,

    full_name           VARCHAR(100) NOT NULL,
    phone               VARCHAR(20),
    gender              ENUM('MALE','FEMALE','OTHER'),

    avatar_url          VARCHAR(255),

    status              ENUM('ACTIVE','INACTIVE','LOCKED')
                        DEFAULT 'ACTIVE',

    last_login_at       DATETIME,

    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,

    created_by          INT NULL,
    updated_by          INT NULL,

    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- =====================================================
-- 2. PASSWORD RESET TOKENS
-- =====================================================

CREATE TABLE password_reset_tokens (
    token_id            INT AUTO_INCREMENT PRIMARY KEY,

    user_id             INT NOT NULL,

    token               VARCHAR(255) NOT NULL UNIQUE,

    expired_at          DATETIME NOT NULL,

    used                BOOLEAN DEFAULT FALSE,

    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- =====================================================
-- 3. ROLES
-- =====================================================

CREATE TABLE roles (
    role_id             INT AUTO_INCREMENT PRIMARY KEY,

    role_name           VARCHAR(50) NOT NULL UNIQUE,

    role_code           VARCHAR(50) NOT NULL UNIQUE,

    description         VARCHAR(255),

    status              ENUM('ACTIVE','INACTIVE')
                        DEFAULT 'ACTIVE',

    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================
-- 4. USER ROLES
-- =====================================================

CREATE TABLE user_roles (
    user_role_id        INT AUTO_INCREMENT PRIMARY KEY,

    user_id             INT NOT NULL,
    role_id             INT NOT NULL,

    assigned_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    assigned_by         INT NULL,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (assigned_by) REFERENCES users(user_id),

    UNIQUE(user_id, role_id)
);

-- =====================================================
-- 5. PERMISSIONS
-- =====================================================

CREATE TABLE permissions (
    permission_id       INT AUTO_INCREMENT PRIMARY KEY,

    permission_name     VARCHAR(100) NOT NULL,
    permission_code     VARCHAR(100) NOT NULL UNIQUE,

    module_name         VARCHAR(100),

    description         VARCHAR(255)
);

-- =====================================================
-- 6. ROLE PERMISSIONS
-- =====================================================

CREATE TABLE role_permissions (
    role_permission_id  INT AUTO_INCREMENT PRIMARY KEY,

    role_id             INT NOT NULL,
    permission_id       INT NOT NULL,

    granted_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id),

    UNIQUE(role_id, permission_id)
);

-- =====================================================
-- 7. USER LOGIN HISTORY
-- =====================================================

CREATE TABLE login_history (
    login_id            INT AUTO_INCREMENT PRIMARY KEY,

    user_id             INT NOT NULL,

    login_time          DATETIME NOT NULL,

    logout_time         DATETIME,

    ip_address          VARCHAR(50),

    user_agent          TEXT,

    login_status        ENUM('SUCCESS','FAILED'),

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- =====================================================
-- 8. AUDIT LOGS
-- =====================================================

CREATE TABLE audit_logs (
    log_id              INT AUTO_INCREMENT PRIMARY KEY,

    user_id             INT,

    action_type         VARCHAR(100),

    description         TEXT,

    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- =====================================================
-- INDEXES
-- =====================================================

CREATE INDEX idx_users_email
ON users(email);

CREATE INDEX idx_users_username
ON users(username);

CREATE INDEX idx_login_history_user
ON login_history(user_id);

CREATE INDEX idx_audit_user
ON audit_logs(user_id);

-- =====================================================
-- SAMPLE ROLES
-- =====================================================

INSERT INTO roles (
    role_name,
    role_code,
    description
)
VALUES
('Administrator','ADMIN','System administrator'),
('HR Manager','HR','Human resource manager'),
('Employee','EMPLOYEE','Normal employee');

-- =====================================================
-- SAMPLE PERMISSIONS
-- =====================================================

INSERT INTO permissions (
    permission_name,
    permission_code,
    module_name
)
VALUES

('View Homepage','HOME_VIEW','Homepage'),

('Login','LOGIN','Authentication'),
('Logout','LOGOUT','Authentication'),
('Forgot Password','FORGOT_PASSWORD','Authentication'),
('View Profile','VIEW_PROFILE','Profile'),
('Change Password','CHANGE_PASSWORD','Profile'),

('View User List','USER_LIST','User Management'),
('View User Detail','USER_DETAIL','User Management'),
('Add User','USER_ADD','User Management'),
('Update User','USER_UPDATE','User Management'),
('Deactivate User','USER_DEACTIVATE','User Management'),

('View Role List','ROLE_LIST','Role Management'),
('View Role Permissions','ROLE_PERMISSION_VIEW','Role Management'),
('Update Role','ROLE_UPDATE','Role Management'),
('Deactivate Role','ROLE_DEACTIVATE','Role Management'),
('Edit Role Permissions','ROLE_PERMISSION_EDIT','Role Management');

-- =====================================================
-- ROLE PERMISSIONS
-- =====================================================

-- ADMIN gets all permissions

INSERT INTO role_permissions(role_id, permission_id)
SELECT 1, permission_id
FROM permissions;

-- EMPLOYEE permissions

INSERT INTO role_permissions(role_id, permission_id)
VALUES
(3,1),
(3,2),
(3,3),
(3,4),
(3,5),
(3,6);

-- =====================================================
-- SAMPLE USERS
-- PASSWORD: 123456
-- =====================================================

INSERT INTO users (
    username,
    email,
    password_hash,
    full_name,
    phone,
    gender,
    status
)
VALUES

(
'admin',
'admin@gmail.com',
-- Use real BCrypt hash for '123456'
'$2a$10$Oqq14BqJ/0Z.Lq.0R44.4eyp25LzJtN7EaZ9a62yD8l.Q7X2K4x2O',
'System Administrator',
'0909999999',
'MALE',
'ACTIVE'
),

(
'employee1',
'employee1@gmail.com',
-- Use real BCrypt hash for '123456'
'$2a$10$Oqq14BqJ/0Z.Lq.0R44.4eyp25LzJtN7EaZ9a62yD8l.Q7X2K4x2O',
'Nguyen Van A',
'0911111111',
'MALE',
'ACTIVE'
);

-- =====================================================
-- USER ROLES
-- =====================================================

INSERT INTO user_roles (
    user_id,
    role_id
)
VALUES
(1,1),
(2,3);

-- =====================================================
-- SAMPLE LOGIN HISTORY
-- =====================================================

INSERT INTO login_history (
    user_id,
    login_time,
    login_status
)
VALUES
(1,NOW(),'SUCCESS');

-- =====================================================
-- SAMPLE AUDIT LOGS
-- =====================================================

INSERT INTO audit_logs (
    user_id,
    action_type,
    description
)
VALUES
(
1,
'CREATE_USER',
'Admin created employee1 account'
);
