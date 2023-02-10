<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/resources/join.css");
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
				<span style="font-size: 1.2em;">회원가입</span>
				<div class="join_m">
					<form action="/member/join" method="post">
						<input type="hidden" name="location" value="<%=location%>">
						아이디: <input name='member_id' placeholder=" 6~12자" maxlength="12" required><br>
						비밀번호: <input name='password' type="password" placeholder="8~14자"
							maxlength="14" required><br> 비밀번호 확인: <input
							name="pwCheck" type="password" placeholder="8~14자" maxlength="14"
							required><br>이름: <input name='member_name'
							placeholder=" 2~6자" required><br> 이메일: <input
							name='email' type="email" placeholder=" (선택)"><br>
						<button class="" type="submit">가입하기</button>
						<a href="/member/login?location=/"> 로그인 </a>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>