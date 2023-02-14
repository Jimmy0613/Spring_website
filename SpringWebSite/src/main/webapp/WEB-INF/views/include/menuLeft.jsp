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
	MemberVO member = (MemberVO)request.getAttribute("loginMember");
	%>
	<div class="member">
		<div class="member_info" style="min-height:100px;">
		<p style="margin: 10px;">내 정보</p>
			<%
			if (member == null) {
			%>
			<div>
				<span style="color:grey;">로그인이 필요합니다.</span> <br><br> <a style="font-size: 0.9em;"
					href="/member/login?location=/board/list">로그인</a> <a
					style="font-size: 0.9em;" href="/member/join?location=/board/list">
					회원가입 </a>
			</div>
			<%
			} else {
			%>
			<div class="login_info">
				<span><%=member.getInfo()%> </span> <span
					style="text-align: center;"><b style="color:red;">❤</b> : <%=member.getHeart_count()%>개</span>
				<div id="f">
					<button id="memberinfo" onclick="location.href='/member/myPage?mode=post'">회원정보</button>
					<form id="logout" action="/member/logout" method="get">
						<input type="hidden" name="location" value="/board/list">
						<button type="submit">로그아웃</button>
					</form>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<hr>
	</div>
	<form action="/board/search">
		<p id="search">
			<input type="hidden" name="category" value="all"> <input
				type="hidden" name="key" value="title"> <input
				name="keyword" placeholder="검색어 입력">
			<button type="submit">검색</button>
		</p>
	</form>
	<div id="board_name">
		<div>
			<p class="board_name">
				<a href="/board/list?category=notice">공지사항</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/board/list?category=general">자유게시판</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/board/list?category=anonym">익명게시판</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/board/list?category=report">신고게시판</a>
			</p>
		</div>
	</div>
</body>
</html>