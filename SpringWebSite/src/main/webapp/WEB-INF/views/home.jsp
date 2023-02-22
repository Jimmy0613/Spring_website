<%@page import="com.cre.website.service.MemberServiceImpl"%>
<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="javax.websocket.Session"%>
<%@page import="com.cre.domain.MemberVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크레닷컴</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/home.css?version=${System.currentTimeMillis()}" />
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
			<div class="member_info">
				<p style="margin: 10px;">내 정보</p>
				<c:choose>
					<c:when test="${loginMember==null}">
						<div style="padding: 20px;">
							<span style="color: grey;">로그인이 필요합니다.</span> <br> <br>
							<a style="font-size: 0.9em;" href="/member/login">로그인</a>
							<a style="font-size: 0.9em;" href="/member/join">
								회원가입 </a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="login_info"
							style="align-items: center; justify-content: center;">
							<div id="f">
								<div style="grid-column-start: 1; grid-column-end: 3;">
									${loginMember.info()} <br> <b style="color: red;">❤</b> :
									${loginMember.heart_count}개
								</div>
								<button id="memberinfo"
									onclick="location.href='/member/myPage/'">회원정보</button>
								<form id="logout" action="/member/logout" method="get">
									<button type="submit">로그아웃</button>
								</form>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="rps">
				<p style="margin: 10px;">
					<span>하트 걸고 가위바위보?!<img
						src="/resources/img/questionmark.jpg"
						style="width: 25px; vertical-align: center;"
						title="이기면 +2, 지면 -1, 비기면 0!"></span><br> <span
						style="font-size: 0.7em;">가위 바위 보 글자를 클릭하면 바로 도전!</span><br>
				</p>
				<c:choose>
					<c:when test="${loginMember==null}">
						<div style="padding: 10px; color: grey;">로그인이 필요합니다.</div>
					</c:when>
					<c:otherwise>
						<div id="rps" style="padding: 10px;">
							<span>오늘 남은 횟수: ${3-count}회 </span> <br>
							<c:choose>
								<c:when test="${3-count>0}">
									<span id="rtext"> <a href="/member/rps?input=s">가위✌</a>
										| <a href="/member/rps?input=r">바위✊</a> | <a
										href="/member/rps?input=p">보🖐</a>
									</span>
								</c:when>
								<c:otherwise>
									<span>&#187; 오늘 기회를 모두 사용했습니다. &#171;</span>
								</c:otherwise>
							</c:choose>
						</div>
					</c:otherwise>
				</c:choose>

			</div>

			<div class="notice">
				<p style="margin: 10px;">
					공지사항 <a href="/board/notice"
						style="font-size: 0.8em;">더보기</a>
				</p>
				<div id="notice">
					<c:if test="${homeNotice!=null}">
						<c:forEach var="notice" items="${homeNotice}">
							<div id="n">
								[ 운영자 ] <a
									href="/board/read?post_num=${notice.post_num}&category=notice&currentPage=1">${notice.title}</a>
								<hr>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="hot">
				<p style="margin: 10px;">
					인기글 <a href="/board/popular" style="font-size: 0.8em;">더보기</a>
				</p>
				<div id="hot">
					<c:if test="${homePopular!=null}">
						<c:forEach var="popular" items="${homePopular }">
							<div id="n">
								<c:choose>
									<c:when test="${popular.category eq 'anonym'}">
										[익명]
									</c:when>
									<c:otherwise>
										[자유]
									</c:otherwise>
								</c:choose>
								<a
									href="/board/read?post_num=${popular.post_num}&category=popular&currentPage=1">${popular.title}
								</a>
								<hr>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<div class="game">
				<p style="margin: 10px;">
					COLORFUL(게임) <a style="font-size: 0.8em;">바로가기</a>
				</p>
				<img src="/resources/img/rpg.png"
					style="width: 320px; margin-left: 10px;">
			</div>
			<div class="sample"></div>
		</div>
	</div>
</body>
</html>