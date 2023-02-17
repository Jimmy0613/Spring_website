<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cre.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpringWebsite</title>
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
				<%@ include file="/WEB-INF/views/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%@ include file="/WEB-INF/views/include/menuLeft.jsp"%>
			</div>
			<div class="write">
				<%
				MemberVO loginMember = (MemberVO) request.getAttribute("loginMember");
				if (loginMember == null) {
					response.sendRedirect("/board/popular");
				} else {
					Long post_num = (Long) request.getAttribute("post_num");
					String reported_user = (String) request.getAttribute("reported_user");
				%>
				<span style="font-size: 1.3em;">신고하기</span>
				<form action="/board/report" method="post">
					<input id="writer" type="hidden"
						value="<%=loginMember.getMember_id()%>" name='reporter_id'>
					<br>글 번호 <input style="width: 50px; height: 30px;"
						name='post_num' value="<%=post_num%>"> &nbsp;신고할 회원 <input
						style="width: 100px; height: 30px;" name='reported_user'
						value="<%=reported_user%>"><br> <span
						style="font-size: 0.7em;">* 댓글일 경우 댓글이 작성된 글의 번호가 입력됩니다.<br>
						* 익명게시판일 경우 익명이라고 입력됩니다.
					</span><br> <br> 신고 사유 선택 <select name='reason'
						style="height: 30px; width: 200px;">
						<option value="욕설/비방/성희롱/음담패설">욕설/비방/성희롱/음담패설</option>
						<option value="게시글/댓글 도배">게시글/댓글 도배</option>
						<option value="광고/홍보">광고/홍보</option>
						<option value="기타 사유">기타 사유(내용 필수 입력)</option>
					</select><br> <br>
					<textarea style="width: 430px; height: 200px; resize: none;"
						placeholder="사유가 분명할 경우 생략 가능" name='content'></textarea>
					<button id="write_button" type="submit">신고하기</button>
				</form>
				<%
				}
				%>
			</div>
		</div>
	</div>


</body>
</html>