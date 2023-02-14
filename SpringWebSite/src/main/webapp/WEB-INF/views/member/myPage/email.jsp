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
					<span id="t">이메일</span> <br>
					<div class="email">
						<form action="/member/myPage/email" method="post">
							<%
							MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
							if (loginMember != null) {
								if (loginMember.getEmail().equals("미등록")) {
							%>
							<p>
								<input type="hidden" name='member_id'
									value="<%=loginMember.getMember_id()%>"> <input
									name='email' type="email" placeholder="ex)abc@123.com" required>
								<button type="submit" style="background-color: #d2eed7;">
									등록</button>
							</p>
							<%
							} else {
							%>
							<p>
								<input type="hidden" name='member_id'
									value="<%=loginMember.getMember_id()%>"> <input
									name='email' type="email"
									placeholder="<%=loginMember.getEmail()%>" required>
								<button type="submit" style="background-color: #d2eed7;">
									변경</button>
							</p>
							<%
							}
							}
							%>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>