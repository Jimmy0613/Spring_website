<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css?version=${System.currentTimeMillis()}" />

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
				<c:set var="writer" value="${loginMember.member_name}" />
				<c:choose>
					<c:when test="${category eq 'anonym'}">
						<span style="font-size: 1.3em;">익명게시판</span>
						<c:set var="writer" value="익명" />
					</c:when>
					<c:when test="${category eq 'notice'}">
						<span style="font-size: 1.3em;">공지사항</span>
					</c:when>
					<c:when test="${category eq 'general'}">
						<span style="font-size: 1.3em;">자유게시판</span>
					</c:when>
				</c:choose>
				<form action="/board/write" method="post">
					<br> <input type="hidden" name='writer_id'
						value="${loginMember.member_id}"> <input id="title"
						placeholder="제목" name='title'> <input id="writer"
						value="${writer}" name='writer' readonly><br>
					<textarea id="content" placeholder="내용" name='content'></textarea>
					<button id="write_button" type="submit">글쓰기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>