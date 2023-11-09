<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String perm = request.getParameter("perm");
		int USER_NUM = 0;
		USER_NUM = Integer.parseInt(request.getParameter("USER_NUM"));
	%>
	<p>권한 : <%= perm %>
	<p>아이디 번호 : <%=USER_NUM %>
</body>
</html>