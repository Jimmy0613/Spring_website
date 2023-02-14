<%@page import="com.cre.website.service.BoardServiceImpl"%>
<%@page import="com.cre.website.service.BoardService"%>
<%@page import="com.cre.domain.BoardVO"%>
<%@page import="com.cre.domain.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cre.domain.MemberVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
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
					<span id="t">내가 쓴 댓글</span> <br>
					<div class="list">
						<div class="list_m">
							<div class="list_n" style="background-color: white;">
								<div>게시판</div>
								<div>내용</div>
								<div>♡</div>
								<div>글번호</div>
								<hr>
							</div>
							<%
							MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
							List<ReplyVO> myreply = (List<ReplyVO>) request.getAttribute("myReply");
							if (myreply.size() != 0) {
								for (ReplyVO r : myreply) {
									String content = "";
									if (r.getContent().length() > 16) {
								content = r.getContent().substring(0, 16) + "...";
									} else {
								content = r.getContent();
									}
									String category = "자유게시판";
									switch (r.getCategory()) {
									case "anonym":
								category = "익명게시판";
								break;
									case "report":
								category = "신고하기";
								break;
									case "notice":
								category = "공지사항";
								break;
									}
							%>
							<div class="list_z">
								<div class="list_n">
									<div><%=category%></div>
									<div style="text-align: left;">
										<a
											href="/board/read?post_num=<%=r.getPost_num()%>&category=<%=r.getCategory()%>"><%=content%></a>
									</div>
									<div></div>
									<div><%=r.getPost_num()%></div>
								</div>
								<%
								}
								%>
								<br>
								<%
								} else {
								%>
								<div>작성한 댓글이 없습니다.</div>
								<%
								}
								%>
							</div>
							<div class="page">
								<%@ include file="/WEB-INF/views/include/page/pageMyReply.jsp"%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>