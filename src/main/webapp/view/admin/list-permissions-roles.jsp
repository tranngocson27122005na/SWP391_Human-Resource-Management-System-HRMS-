<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Role Permissions</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/admin/role-permissions" method="post">
    <table border="1">
        <tr>
            <th>Role Name</th>
            <th>Permission</th>
            <th>Delete</th>
            <th>Add</th>
        </tr>
        <c:forEach var="role" items="${roles}">
            <!-- Tạo key động để lấy danh sách permission -->
            <c:set var="permsKey" value="permissions_${role.roleId}" />
            <c:set var="perms" value="${requestScope[permsKey]}" />

            <c:forEach var="p" items="${perms}" varStatus="status">
                <tr>
                    <c:if test="${status.first}">
                        <td rowspan="${fn:length(perms)}">${role.roleName}</td>
                    </c:if>
                    <td>${p.permissionName}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/deleteRolePermission?roleId=${role.roleId}&permissionId=${p.permissionId}">Delete</a>
                    </td>
                    <c:if test="${status.first}">
                        <td rowspan="${fn:length(perms)}">
                            <a href="addPermission?roleId=${role.roleId}">Add</a>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>

            <c:if test="${fn:length(perms) == 0}">
                <tr>
                    <td>${role.roleName}</td>
                    <td colspan="2">No permissions</td>
                    <td><a href="addPermission?roleId=${role.roleId}">Add</a></td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</form>
</body>
</html>
