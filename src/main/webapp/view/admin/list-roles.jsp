<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách Roles</title>
</head>
<body>
<h2>Danh sách Roles</h2>
<form action="${pageContext.request.contextPath}/admin/roles" method="post">
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Tên Role</th>
        <th>Active</th>
    </tr>
    <c:forEach var="role" items="${roles}">
        <tr>
            <td>${role.roleId}</td>
            <td>${role.roleName}</td>
            <td>
                <input type="radio" name="active_${role.roleId}" value="true"
                       <c:if test="${role.active}">checked</c:if> /> Active
                <input type="radio" name="active_${role.roleId}" value="false"
                       <c:if test="${!role.active}">checked</c:if> /> Inactive
            </td>
        </tr>
    </c:forEach>
</table>
    <input type="submit" value="update">
</form>
</body>
</html>
