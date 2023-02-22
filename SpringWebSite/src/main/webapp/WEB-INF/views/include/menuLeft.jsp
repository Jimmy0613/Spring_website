<%@page import="com.cre.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 왼쪽 메뉴</title>
<script type="text/javascript">
	function inputCheck(){
		var searchForm = document.searchForm;
		var input = searchForm.keyword.value;
		if(input=="" || input==null){
			alert("검색어를 입력하세요.");
			return false;
		}
		searchForm.action = "${contextPath}/board/search";
		searchForm.method = "get";
		searchForm.submit();
	}
</script>
</head>
<body>
	<div class="member">
		<div class="member_info" style="min-height: 145px;">
			<p style="margin: 10px;">내 정보</p>
			<c:choose>
				<c:when test="${loginMember==null}">
					<div>
					<br>
						<span style="color: grey; padding:10px;">로그인이 필요합니다.</span> <br> <br>
						<a style="font-size: 0.9em; padding:10px;"
							href="/member/login">로그인</a> <a
							style="font-size: 0.9em; padding:10px;"
							href="/member/join"> 회원가입 </a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="login_info">
						<span>${loginMember.info()} </span> <span
							style="text-align: center;"><b style="color: red;">❤</b> :
							${loginMember.heart_count}개</span>
						<div id="f">
							<button id="memberinfo" onclick="location.href='/member/myPage/'">회원정보</button>
							<form id="logout" action="/member/logout" method="get">
								<button type="submit">로그아웃</button>
							</form>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<hr>
	</div>
	<form name="searchForm" method="get">
		<p id="search">
			<input type="hidden" name='category' value="all"> <input
				type="hidden" name='key' value="all"> <input
				name='keyword' placeholder="전체 검색">
			<button onclick="inputCheck()">검색</button>
		</p>
	</form>
	<div id="board_name">
		<div>
			<p class="board_name">
				<a href="/board/notice">공지사항</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/board/general">자유게시판</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/board/anonym">익명게시판</a>
			</p>
		</div>
		<c:if test="${loginMember.member_id eq 'manager'}">
			<hr>
			<div>
				<p class="board_name">

					<a href="/admin/report">신고내역 ⚙</a>
				</p>
			</div>
		</c:if>
	</div>
</body>
</html>