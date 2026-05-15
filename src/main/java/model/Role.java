package model;

public class Role {
    private int roleId;
    private String roleName;
    private boolean isActive;

    public Role() {
    }

    public Role(int roleId, String roleName, boolean isActive) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.isActive = isActive;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    @Override
    public String toString() {
        return   roleId+
                ", " + roleName+
                ", " + isActive;
    }
}

