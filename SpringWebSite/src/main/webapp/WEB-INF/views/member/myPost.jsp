<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cre.domain.MemberVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/resources/css/mypage.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/resources/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/resources/css/mypage.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	List<BoardVO> myPost = (List<BoardVO>) request.getAttribute("myPost");
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/WEB-INF/views/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="mypage">
				<%@include file="/WEB-INF/views/include/myInfo.jsp"%>
				<div id="x">
					<span id="t">내가 쓴 글</span> <br>
					<div class="list">
						<div class="list_m">
							<div class="list_n" style="background-color: white;">
								<div>게시판</div>
								<div>제목</div>
								<div>♡</div>
								<div>조회수</div>
								<hr>
							</div>
							<div class="list_z">
								<%
								if (myPost.size() != 0) {
									for (BoardVO b : myPost) {
										String title = "";
										if (b.getTitle().length() > 16) {
									title = b.getTitle().substring(0, 16) + "...";
										} else {
									title = b.getTitle();
										}
										if (b.getReply_count() > 0)
									title += " (" + b.getReply_count() + ")";
										String category = "자유게시판";
										if (b.getCategory().equals("anonym")) {
									category = "익명게시판";
										} else if (b.getCategory().equals("report")) {
									category = "신고하기";
										}
								%>

								<div class="list_n">
									<div><%=category%></div>
									<div style="text-align: left;">
										<a
											href="/board/read?post_num=<%=b.getPost_num()%>&category=<%=b.getCategory()%>"><%=title%></a>
									</div>
									<div><%=b.getHeart_count()%></div>
									<div><%=b.getView_count()%></div>
								</div>
								<%
								}
								%>
								<%
								} else {
								%>
								<div>작성한 글이 없습니다.</div>
								<%
								}
								%>
							</div>
							<div class="page">
								<%@ include file="/WEB-INF/views/include/page/pageMyPost.jsp"%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>