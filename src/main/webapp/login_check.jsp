<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Members.Members" %>
<%@ page import="Members.MembersDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="main.css" />
</head>
<%	if(session.getAttribute("USER_ID")==null){%>
       		<div class="section1">
	              <div class="main_nav">
	                  <div>
	                      <ul class="sign">
	                          <li><a href="login.jsp">로그인</a></li>
	                          <li> | </li>
	                          <li><a href="signup.jsp">회원가입</a></li>
	                      </ul>
	                  </div>
	                  <div class="logo">
	                      <a href=main.jsp><img class="logo_size" src="logo.png"></a>
	                  </div>
	                  <div>
	                      <ul class="menu">
	                          <li><a href="board_report.jsp">신고</a></li>
	                          <li>|</li>
	                          <li><a href="Cars.jsp">전체 차량 보기</a></li>
	                          <li>|</li>
	                          <li><a href="bbs.jsp">게시판</a></li>
	                      </ul>
	                  </div>
	              </div>
          	</div>
       	<%	}else{%>
       	<%		if(session.getAttribute("USER_PERM").equals("admin")){%>
       		<div class="section1">
              <div class="main_nav">
                  <div>
                      <ul class="sign">
					<li><strong><%=session.getAttribute("USER_ID") %></strong>님</li>
                          <li> | </li>
                          <li><a href="logout.jsp">로그아웃</a></li>
                          <li> | </li>
                          <li><a href="addCar.jsp">차량등록</a></li>
                          <li> | </li>
                          <li><a href="admin_main.jsp">관리자 페이지</a></li>
                      </ul>
                  </div>
                  <div class="logo">
                      <a href=main.jsp><img class="logo_size" src="logo.png"></a>
                  </div>
                  <div>
                      <ul class="menu">
                          <li><a href="board_report.jsp">신고</a></li>
                          <li>|</li>
                          <li><a href="Cars.jsp">전체 차량 보기</a></li>
                          <li>|</li>
                          <li><a href="bbs.jsp">게시판</a></li>
                      </ul>
                  </div>
              </div>
          </div>
       	<%		}else{%>
       	<div class="section1">
              <div class="main_nav">
                  <div>
                      <ul class="sign">
					<li><strong><%=session.getAttribute("USER_ID") %></strong>님</li>
                          <li> | </li>
                          <li><a href="logout.jsp">로그아웃</a></li>
                      </ul>
                  </div>
                  <div class="logo">
                      <a href=main.jsp><img class="logo_size" src="logo.png"></a>
                  </div>
                  <div>
                      <ul class="menu">
                          <li><a href="board_report.jsp">신고</a></li>
                          <li>|</li>
                          <li><a href="Cars.jsp">전체 차량 보기</a></li>
                          <li>|</li>
                          <li><a href="bbs.jsp">게시판</a></li>
                          <li>|</li>
                          <li><a href="addCar.jsp">차량등록</a></li>
                      </ul>
                  </div>
              </div>
          </div>	
       	<%		}%>
       	<%	}%>
</body>
</html>