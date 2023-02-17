<%@page import="com.cre.domain.ReportVO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpringWebsite</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/resources/css/list.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/resources/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/resources/css/board.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/resources/css/list.css?ver=<%=fmt.format(lastModifiedStyle)%>">
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
				<div style="font-size: 1.3em; font-weight: bolder; color: black;">신고
					내역</div>
				<br>
				<div class="list_m">
					<div></div>
					<div class="list_z">
						<%
						List<ReportVO> list = (List<ReportVO>) request.getAttribute("list");
						if (list.size() != 0) {
							for (ReportVO b : list) {
						%>
						<div class="list_r" style="background-color: white;">
							<span id="ra">신고자 아이디: <%=b.getReporter_id()%> | 글번호: <%=b.getPost_num()%></span><br>
							<span id="rb"> 피신고자 이름: <%=b.getReported_user()%> | 사유: <%=b.getReason()%></span><br>
							<span id="rc"> 신고 내용: <%=b.getContent()%></span>
							<hr>
						</div>
						<%
						}
						} else {
						%>
						신고 내역이 없습니다.
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>