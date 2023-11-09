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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style>
.button_select{
	position:absolute;
	list-style-type:none;
	padding:0;
}
.button_select li{
    float:left;
    padding-right:5px;
}
</style>
</head>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String USER_ID = null;
		if(session.getAttribute("USER_ID") != null){
			USER_ID = (String)session.getAttribute("USER_ID");
		}
		int USER_NUM = 0;
		if(request.getParameter("USER_NUM") != null){
			USER_NUM = Integer.parseInt(request.getParameter("USER_NUM"));
		}
		
		// 만약 넘어온 데이터가 없다면
		if(USER_NUM == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근이 거부되었습니다.')");
			script.println("location.href='admin_main.jsp'");
			script.println("</script>");
		}
		
		// 유효한 글이라면 구체적인 정보를 'bbs'라는 인스턴스에 담는다
		Members Members = new MembersDAO().getMembers(USER_NUM);
	%>
	<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				// 로그인 하지 않았을 때 보여지는 화면
				if(USER_ID == null){
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="signup.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인이 되어 있는 상태에서 보여주는 화면
				}else{
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><%=USER_ID %>님<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->
	
	<!-- 게시판 글 보기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">조회된 회원 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align: left">회원 아이디 : <%= Members.getUSER_ID() %></td>
					</tr>
					<tr>
						<td style="text-align: left">회원 이름 : <%= Members.getUSER_NAME() %></td>
					</tr>
					<tr>
						<td style="text-align: left">회원 닉네임 : <%= Members.getUSER_NICK() %></td>
					</tr>
					<tr>
						<td style="text-align: left">회원 권한 : <%= Members.getUSER_PERM() %></td>
					</tr>
					<tr>
						<td style="text-align: left">회원 이메일 : <%= Members.getUSER_EMAIL() %></td>
					</tr>
					<tr>
						<td style="text-align: left">회원 전화번호 : <%= Members.getUSER_PHONE() %></td>
					</tr>
				</tbody>
			</table>
			<fieldset>
			<form action="grant.jsp?USER_NUM=<%=USER_NUM%>">
				<legend>권한 수정</legend>
				<input type="radio" name="perm" value="admin">관리자
				<br>
				<input type="radio" name="perm" value="dealer">딜러
				<br>
				<input type="radio" name="perm" value="member">일반회원
			<br>
			<ul class="button_select">
				<li><input type="submit" value="권한 부여"  style="text-align:center"></form></li>
				<li><form action="ban.jsp?USER_NUM=<%= Members.getUSER_NUM() %>">
				<input type="submit" value="강제탈퇴" style="text-align:center">
				</form>
				</li>
			</ul>
			</fieldset>
		</div>
	</div>
	<!-- 게시판 글 보기 양식 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.js"></script>
</body>
</html>