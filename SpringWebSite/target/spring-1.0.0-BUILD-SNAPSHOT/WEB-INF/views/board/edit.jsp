<%@page import="com.cre.domain.BoardVO"%>
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
<title>SpringWebsite</title>
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
	<%
	BoardVO read = (BoardVO)request.getAttribute("read");
	Long post_num = read.getPost_num();
	String content = read.getContent().replace("<br>", "\r\n");
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/WEB-INF/views/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%-- <%@ include file="/include/menuLeft.jsp"%> --%>
			</div>
			<div class="write">
				<span style="font-size: 1.2em;">수정</span>
				<form action="/board/edit" method="post">
					<input type="hidden" name='post_num' value="<%=post_num%>">
					<%-- <input type="hidden" name="category" value="<%=category%>"> --%>
					<input id="title" placeholder="제목" name='title'
						value="<%=read.getTitle()%>"> <input id="writer"
						placeholder="<%=read.getWriter()%>" readonly><br>
					<textarea id="content" name='content'><%=content%></textarea>
					<button id="write_button" type="submit">수정하기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>