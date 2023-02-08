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
	<div style="font-size: 1.2em; font-weight: bolder; color: black;">게시판
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
			Object o = request.getAttribute("list");
			List<BoardVO> list = (List<BoardVO>) o;
			if (list.size() != 0) {
				for (BoardVO b : list) {
			%>
			<div class="list_n" style="background-color: white;">
				<%-- <%
				if (cgb.equals("anonym")) {
				%>
				<div>익명</div>
				<%
				} else {
				%> --%>
				<div><%=b.getWriter()%></div>
				<%-- <%
				}
				%> --%>
				<div id="t">
					<%
					String title = "";
					if (b.getTitle().length() > 14) {
						title = b.getTitle().substring(0, 14) + "...";
					} else {
						title = b.getTitle();
					}
					%>
					<a href="/board/read?post_num=<%=b.getPost_num() %>" title="<%=b.getTitle()%>"><%=title%> <%
 if (b.getReply_count() > 0) {
 %> (<%=b.getReply_count()%>) <%
 }
 %></a>
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
	<!-- 페이징 부분 -->
	<div class="page">
		<%@ include file="/WEB-INF/views/include/pageBoard.jsp"%>
	</div>
	<!-- 페이징 부분 -->
	<div>
		<%-- <%
	MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
	if (loginMember != null) {
		if (cgb.equals("notice")) {
			if (loginMember.getId().equals("manager")) {
	%>
	<button
		onclick="location.href='/write.jsp?category=<%=cgb%>'">글쓰기</button>
	<%
	}
	} else {
	%> --%>
		<button onclick="location.href='/board/write'">글쓰기</button>
		<%-- <%
	}
	}
	%> --%>
	</div>

</body>
</html>