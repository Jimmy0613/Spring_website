<%@page import="com.cre.domain.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cre.domain.BoardVO"%>
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
<!-- <script type="text/javascript">
	function del_confirm() {
		var ok = confirm("정말 삭제하시겠습니까?");
		var formDelete = document.formDelete;
		var postNum = formDelete.postNum.value;
		var page = formDelete.page.value;
		var category = formDelete.category.value;
		if (ok) {
			formDelete.method = "get";
			formDelete.action = "/board/delete";
			formDelete.submit();
		} else {
			location.href = "/board/read?postNum=" + postNum + "&page="
					+ category + "&category=" + category;
		}
	}
</script> -->

<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/resources/css/board.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/resources/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/resources/css/board.css?ver=<%=fmt.format(lastModifiedStyle)%>">
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
			<%
			String category = (String) request.getAttribute("category");
			String cgk = "자유게시판";
			switch (category) {
			case "anonym":
				cgk = "익명게시판";
				break;
			case "notice":
				cgk = "공지사항";
				break;
			case "report":
				cgk = "신고하기";
				break;
			}
			%>
			<div class="post">
				<div style="font-size: 1.3em; font-weight: bolder; color: black;"><%=cgk%>
				</div>
				<br>
				<%
				MemberVO loginMember = (MemberVO) request.getAttribute("loginMember");
				BoardVO read = (BoardVO) request.getAttribute("read");
				int currentPage = (Integer) request.getAttribute("currentPage");
				Long post_num = read.getPost_num();
				%>
				<div class="p">
					<div id="p" style="font-weight: bolder"><%=read.getTitle()%>
					</div>
					<div id="p">
						<%=read.getWriter()%>
						|
						<%=read.getPost_date()%>
						| 조회수
						<%=read.getView_count()%></div>
					<div id="c"><%=read.getContent()%></div>
					<div id="p" style="display: flex;">
						댓글
						<%=read.getReply_count()%>개 | 하트
						<%=read.getHeart_count()%>개
						<%
					if (loginMember != null && (!loginMember.getMember_id().equals(read.getWriter_id()))) {
					%>
						<form action="/board/heart" method="get">
							<input type="hidden" name='post_num'
								value="<%=read.getPost_num()%>"> <input type="hidden"
								name='writer_id' value="<%=read.getWriter_id()%>"> <input
								type="hidden" name='member_id'
								value="<%=loginMember.getMember_id()%>">
							<button id="heartBtn" type="submit">❤</button>
						</form>
						<%
						}
						%>
					</div>
					<hr style="height: 0.1px; width: 95%;">
					<div id="p" style="color: black; font-size: 0.9em;">
						<%
						List<ReplyVO> reply = (List<ReplyVO>) request.getAttribute("reply");
						if (reply.size() != 0) {

							for (ReplyVO r : reply) {
						%>
						<div id="reply">
							<%=r.getWriter()%>:
							<%=r.getContent()%>
							(<%=r.getReply_date()%>)
							<%
							if (loginMember != null) {
								if (r.getWriter().equals(loginMember.getMember_name())) {
							%>
							<form id="delReply" method="get" action="/board/delReply"
								encType="UTF-8">
								<input type="hidden" name='writer_id'
									value="<%=r.getWriter_id()%>"> <input type="hidden"
									name='post_num' value="<%=r.getPost_num()%>"> <input
									type="hidden" name='reply_num' value="<%=r.getReply_num()%>">
								<a type="submit"
									onclick="document.getElementById('delReply').submit();">(x)</a>
							</form>
							<%
							}
							}
							%>
						</div>
						<%
						}
						} else {
						%>
						<div id="reply">아직 댓글이 없습니다.</div>
						<%
						}
						%>
						<%
						if (loginMember != null) {
							String reWriter = loginMember.getMember_name();
							if (category.equals("anonym"))
								reWriter = "익명";
						%>
						<form class="reply" action="/board/reply" method="post">
							<input type="hidden" value="<%=read.getCategory()%>"
								name='category'> <input type="hidden"
								value="<%=post_num%>" name='post_num'> <input
								type="hidden" value="<%=loginMember.getMember_id()%>"
								name='writer_id'> <input type="hidden"
								value="<%=reWriter%>" name='writer'> <input
								name='content' placeholder=" (댓글 작성)">
							<button type="submit">등록</button>
						</form>
						<%
						}
						%>
					</div>
				</div>
				<div id="edl">
					<%
					if (loginMember != null) {
						if (loginMember.getMember_id().equals(read.getWriter_id())) {
					%>
					<button
						onclick="location.href='/board/edit?post_num=<%=post_num%>'">수정</button>
					<button
						onclick="location.href='/board/delete?post_num=<%=post_num%>&writer_id=<%=read.getWriter_id()%>'">삭제</button>
					<%
					}
					}
					%>
					<%-- <form name="formDelete"	encType="UTF-8">
						<input type="hidden" name="postNum" value="<%=postNum%>">
						<input type="hidden" name="category" value="<%=category%>">
						<input type="hidden" name="page" value="<%=currentPage%>">
						<button onclick="del_confirm()">삭제</button>
					</form>
					 --%>
					<button
						onclick="location.href='/board/list?category=<%=category%>&currentPage=<%=currentPage%>'">목록</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>