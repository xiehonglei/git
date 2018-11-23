<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<body>
<h2>Hello World!</h2>
<c:forEach items="${list}" var="user">
    ${user.id}
    ${user.username}
    ${user.password}
</c:forEach>
</body>
</html>