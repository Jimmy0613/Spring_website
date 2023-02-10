<%@page import="com.cre.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
MemberVO user = (MemberVO)session.getAttribute("loginMember");

%>
	<div class="myInfo">
		<span id="t">회원 정보</span><span style="font-size: 0.8em;">
			&nbsp;<a href="/member/logout?location=/">로그아웃</a>
		</span>
		<hr>
		<div id="p">
			<div id="y">
				<div>
					<b>이름</b> <br> <b>아이디</b> <br> <b>이메일</b>
				</div>
				<div><%=user.getMember_name()%><br><%=user.getMember_name()%><br>
					<%
					if (user.getEmail().equals("")) {
					%>
					<!-- <a href="/member/myEmail">등록</a> -->
					<%
					} else {
					%>
					<%=user.getEmail()%><!-- <a href="/member/myEmail"><br>변경</a> -->
					<%
					}
					%>
				</div>
			</div>
			<div id="y">
				<div>
					<b>하트(<b style="color:red;">❤</b>)</b><br> <b>작성 글</b><br> <b>작성 댓글</b><br>
				</div>
				<div>
					<%=user.getHeart_count()%>
					개<br> <a href="/member/myPost"><%=user.getPost_count()%> 개</a><br>
					<a href="/member/myReply"><%=user.getReply_count()%> 개</a><br>
				</div>
			</div>
		</div>
	</div>
</body>
</html>