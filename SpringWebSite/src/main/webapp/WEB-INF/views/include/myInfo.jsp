<%@page import="com.cre.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${loginMember==null}">
		<c:redirect url="/member/login" />
	</c:if>
	<div class="myInfo">
		<span id="t">회원 정보</span><span style="font-size: 0.8em;">
			&nbsp;<a href="/member/logout?location=/">로그아웃</a>
		</span>
		<hr>
		<div id="p">
			<c:if test="${loginMember!=null}">
				<div id="y">
					<div>
						<b>이름</b> <br> <b>아이디</b> <br> <b>이메일</b>
					</div>
					<div>${loginMember.member_name}<br>${loginMember.member_id}<br>
						<c:choose>
							<c:when test="${loginMember.email eq '미등록'}">
								<a href="/member/myPage/email">등록</a>
							</c:when>
							<c:otherwise>
								${loginMember.email}<a href="/member/myPage/email"><br>변경</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div id="y">
					<div>
						<b>하트(<b style="color: red;">❤</b>)
						</b><br> <b>작성 글</b><br> <b>작성 댓글</b><br>
					</div>
					<div>
						${loginMember.heart_count} 개<br> <a href="/member/myPage/post">${loginMember.post_count}
							개</a><br> <a href="/member/myPage/reply">${loginMember.reply_count}
							개</a><br>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>