<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/join.css?version=${System.currentTimeMillis()}" />

</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu"><%@include
					file="/WEB-INF/views/include/menuTop.jsp"%></div>
		</div>
		<div class="content">
			<div class="join">
				<span style="font-size: 1.2em;">로그인</span>
				<div class="join_m">
					<form class="login" action="/member/login" method="post">
						<p>
							아이디<br> <input name='member_id'><br>비밀번호<br>
							<input name='password' type="password"> <br>
							<button id="login_button" type="submit">로그인</button>
							<a href="/member/join"> 회원가입 </a>
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>