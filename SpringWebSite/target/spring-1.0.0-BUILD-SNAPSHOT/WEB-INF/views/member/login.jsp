<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/resources/css/join.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/resources/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/resources/css/join.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	String location = request.getParameter("location");
	if(location==null){
		location="/";
	}
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu"><%@include file="/WEB-INF/views/include/menuTop.jsp"%></div>
		</div>
		<div class="content">
			<div class="join">
				<span style="font-size: 1.2em;">로그인</span>
				<div class="join_m">
					<form class="login" action="/member/login" method="post">
						<p>
							<input type="hidden" name="location" value="<%=location%>">
							아이디<br> <input name='member_id'><br>비밀번호<br> <input
								name='password' type="password"> <br>
							<button id="login_button" type="submit">로그인</button>
							<a href="/member/join?location=/member/login"> 회원가입 </a>
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>