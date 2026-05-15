package model;

import java.time.LocalDateTime;

public class User {
    private int userId;
    private String fullName;
    private String email;
    private String username;
    private String password;
    private int roleId;
    private boolean isActive;
    private LocalDateTime createAt;

    public User() {
    }

    public User(int userId, String fullName, String email, String username, String password, int roleId, boolean isActive, LocalDateTime createAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.isActive = isActive;
        this.createAt = createAt;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return  userId +
            ", " +fullName +
            ", " + email +
            ", " + username +
            ", " + password +
            ", " + roleId +
            ", " + isActive +
            ", " + createAt;
    }
}
