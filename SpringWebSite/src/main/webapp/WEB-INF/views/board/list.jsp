<%@page import="java.net.URLDecoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JspWebsite</title>
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
				<%-- <%@ include file="/include/menuLeft.jsp"%> --%>
			</div>
			<%-- <%
			String category = (String)request.getAttribute("category");
			if (category == null) {
				category = "popular";
			}
			if (category.equals("popular")) {
			%>
			<div class="list">
				<%@ include file="/include/listPopular.jsp"%>
			</div>
			<%
			} else {
			%> --%>
			<div class="list">
				<%@ include file="/WEB-INF/views/include/listBoard.jsp"%>
			</div>
			<%-- <%
			}
			%> --%>
		</div>
	</div>
</body>
</html>