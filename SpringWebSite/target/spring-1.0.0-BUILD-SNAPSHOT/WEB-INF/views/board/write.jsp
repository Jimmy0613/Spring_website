<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JspWebsite</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/resources/css/board.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/resources/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/resources/css/board.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/WEB-INF/views/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%@ include file="/WEB-INF/views/include/menuLeft.jsp"%>
			</div>
			<div class="write">
				<%
				MemberVO loginMember = (MemberVO) request.getAttribute("loginMember");
				String cgw = (String) request.getAttribute("category");
				String writer = loginMember.getMember_name();
				if(cgw.equals("anonym")){
					writer = "익명";
				}
				%>
				<span style="font-size: 1.2em;">글쓰기</span>
				<form action="/board/write" method="post">
					<br> <input type="hidden" name='writer_id' value="<%=loginMember.getMember_id()%>">
					<input id="title" placeholder="제목" name='title'> <input
						id="writer" value="<%=writer %>" name='writer' readonly><br>
					<textarea id="content" placeholder="내용" name='content'></textarea>
					<button id="write_button" type="submit">글쓰기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>