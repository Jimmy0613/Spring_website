<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cre.domain.MemberVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 등록/변경</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/mypage.css?version=${System.currentTimeMillis()}" />

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
							<c:if test="${loginMember!=null}">
								<c:choose>
									<c:when test="${loginMember.email eq '미등록'}">
										<p>
											<input type="hidden" name='member_id'
												value="${loginMember.member_id}"> <input
												name='email' type="email" placeholder="ex)abc@123.com"
												required>
											<button type="submit" style="background-color: #d2eed7;">
												등록</button>
										</p>
									</c:when>
									<c:otherwise>
										<p>
											<input type="hidden" name='member_id'
												value="${loginMember.member_id}"> <input
												name='email' type="email" placeholder="${loginMember.email}"
												required>
											<button type="submit" style="background-color: #d2eed7;">
												변경</button>
										</p>
									</c:otherwise>
								</c:choose>
							</c:if>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>