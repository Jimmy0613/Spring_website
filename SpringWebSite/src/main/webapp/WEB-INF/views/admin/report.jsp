<%@page import="com.cre.domain.ReportVO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고내역</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/list.css?version=${System.currentTimeMillis()}" />
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
				<%@ include file="/WEB-INF/views/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%@ include file="/WEB-INF/views/include/menuLeft.jsp"%>
			</div>
			<div class="list">
				<div style="font-size: 1.3em; font-weight: bolder; color: black;">신고
					내역</div>
				<br>
				<div>
					<div class="list_z">
						<c:choose>
							<c:when test="${list.size()>0}">
								<c:forEach var="r" items="${list}">
									<div class="list_r" style="background-color: white;">
										<hr>
										<b>작성자: <a>${r.reporter_id}</a>&nbsp;&nbsp;(사유: ${r.reason})<br><a href="/board/read?post_num=${r.post_num}">PostNo.${r.post_num}</a>
											&nbsp;&nbsp;신고회원ID: <a>${r.reported_user_id}</a> </b>
										<hr style="border: 0.1px dashed; color: #e7dae0;">
										${fn:replace(r.content,crcn,br)}
										<button
											onclick="location.href='/admin/delReport?report_num=${r.report_num}'">확인/삭제</button>
										<hr>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
						신고 내역이 없습니다.
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>