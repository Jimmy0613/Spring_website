<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인기글</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/list.css?version=${System.currentTimeMillis()}" />

</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@ include file="/WEB-INF/views/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%@ include file="/WEB-INF/views/include/menuLeft.jsp"%>
			</div>
			<div class="list">
				<div style="font-size: 1.3em; font-weight: bolder; color: black;">인기글
				</div>
				<br>
				<div class="list_m">
					<div class="list_n" style="color: black;">
						<div>작성자</div>
						<div>제목</div>
						<div>♡</div>
						<div>조회수</div>
						<hr>
					</div>
					<div class="list_z">
						<c:choose>
							<c:when test="${list.size()!=0}">
								<c:forEach var="p" items="${list}">
									<div class="list_n" style="background-color: white;">
										<c:choose>
											<c:when test="${p.category eq 'anonym'}">
												<div>익명</div>
											</c:when>
											<c:otherwise>
												<div>${p.writer}</div>
											</c:otherwise>
										</c:choose>
										<div id="t">
											<c:set var="title" value="${p.title}" />
											<c:if test="${fn:length(title)>16}">
												<c:set var="title" value="${fn:substring(title,0,16)}..." />
											</c:if>
											<c:if test="${p.reply_count>0}">
												<c:set var="title" value="${title} (${p.reply_count})" />
											</c:if>
											<a title="${p.title}"
												href="/board/read?post_num=${p.post_num}">${title} </a>
										</div>
										<div>${p.heart_count}</div>
										<div>${p.view_count}</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
						아직 글이 없습니다.
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>