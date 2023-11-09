<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Members.MembersDAO" %>
<%@ page import="Members.Members" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		// 세션에 값이 담겨있는지 체크
		String USER_ID = null;
		if(session.getAttribute("USER_ID") != null){
			USER_ID = (String)session.getAttribute("USER_ID");
		}
		if(USER_ID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int USER_NUM = 0;
		if(request.getParameter("USER_NUM") != null){
			USER_NUM = Integer.parseInt(request.getParameter("USER_NUM"));
		}
		// 입력이 안 됐거나 빈 값이 있는지 체크한다
		if(request.getParameter("perm") == null || request.getParameter("perm").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 정상적으로 입력이 되었다면 글 수정 로직을 수행한다
			MembersDAO MembersDAO = new MembersDAO();
			int result = MembersDAO.grant(USER_NUM, request.getParameter("perm"));
			// 데이터베이스 오류인 경우
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정하기에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			// 글 수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정하기 성공')");
				script.println("location.href='admin_main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>