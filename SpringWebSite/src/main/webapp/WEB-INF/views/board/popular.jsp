<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.util.List"%>
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
						<%
						List<BoardVO> popular = (List<BoardVO>) request.getAttribute("popular");
						if (popular.size() != 0) {
							for (BoardVO b : popular) {
						%>
						<div class="list_n" style="background-color: white;">
							<%
							if (b.getCategory().equals("anonym")) {
							%>
							<div>익명</div>
							<%
							} else {
							%>
							<div><%=b.getWriter()%></div>
							<%
							}
							%>
							<div id="t">
								<%
								String title = "";
								if (b.getTitle().length() > 16) {
									title = b.getTitle().substring(0, 16) + "...";
								} else {
									title = b.getTitle();
								}
								if (b.getReply_count() > 0) {
									title += "(" + b.getReply_count() + ")";
								}
								%>
								<a title="<%=b.getTitle()%>"
									href="/board/read?post_num=<%=b.getPost_num()%>"><%=title%>
								</a>
							</div>
							<div><%=b.getHeart_count()%></div>
							<div><%=b.getView_count()%></div>
						</div>
						<%
						}
						} else {
						%>
						아직 글이 없습니다.
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