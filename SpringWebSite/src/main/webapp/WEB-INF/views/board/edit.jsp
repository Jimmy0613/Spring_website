<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css?version=${System.currentTimeMillis()}" />
</head>
<body>
	<%
	pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
	pageContext.setAttribute("br", "<br>"); //br 태그
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
				<%@ include file="/WEB-INF/views/include/menuLeft.jsp"%>
			</div>
			<div class="write">
				<c:choose>
					<c:when test="${read.category eq 'anonym'}">
						<span style="font-size: 1.3em;">익명게시판</span>
					</c:when>
					<c:when test="${read.category eq 'notice'}">
						<span style="font-size: 1.3em;">공지사항</span>
					</c:when>
					<c:when test="${read.category eq 'general'}">
						<span style="font-size: 1.3em;">자유게시판</span>
					</c:when>
				</c:choose>
				<br>
				<form action="/board/edit" method="post">
					<input type="hidden" name='post_num' value="${read.post_num}">
					<input id="title" placeholder="제목" name='title'
						value="${read.title}"> <input id="writer"
						placeholder="${read.writer}" readonly><br>
					<textarea id="content" name='content'>${fn:replace(read.content,br,crcn)}</textarea>
					<button id="write_button" type="submit">수정하기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>