<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="font-size: 1.2em; font-weight: bolder; color: black;">인기글
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
			List<BoardVO> list = (List<BoardVO>) request.getAttribute("list");
			if (list.size() != 0) {
				for (BoardVO b : list) {
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
						href="/board/read?post_num=<%=b.getPost_num()%>"><%=title%> </a>
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
</body>
</html>