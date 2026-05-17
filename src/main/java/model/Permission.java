package model;

public class Permission {
    private int permissionId;
    private String permissionName;
    private String permissionCode;
    private String moduleName;
    private String description;

    public Permission() {
    }

    public Permission(int permissionId, String permissionName, String permissionCode, String moduleName, String description) {
        this.permissionId = permissionId;
        this.permissionName = permissionName;
        this.permissionCode = permissionCode;
        this.moduleName = moduleName;
        this.description = description;
    }

    public int getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(int permissionId) {
        this.permissionId = permissionId;
    }

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName;
    }

    public String getPermissionCode() {
        return permissionCode;
    }

    public void setPermissionCode(String permissionCode) {
        this.permissionCode = permissionCode;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
