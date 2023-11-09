<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*" %>
<%@ page import = "Members.Members" %>
<%@ page import = "Members.MembersDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String USER_ID = request.getParameter("USER_ID");
	String USER_PW = request.getParameter("USER_PW");
%>
<!DOCTYPE>
<html>
    <head>
    	<meta charset="UTF-8">
    </head>
<body>
	<% 
		MembersDAO dao = new MembersDAO();
		Members dto = dao.login(USER_ID, USER_PW);
		PrintWriter script = response.getWriter();
		if(dto.getUSER_ID()!=null){
			session.setAttribute("USER_ID", dto.getUSER_ID());
			session.setAttribute("USER_PERM", dto.getUSER_PERM());
			script.println("<script>");
			script.println("alert('로그인 성공')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else{
			script.println("<script>");
			script.println("alert('로그인이 거부되었습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</html>