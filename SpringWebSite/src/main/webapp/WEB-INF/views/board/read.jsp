<%@page import="com.cre.domain.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="com.cre.domain.BoardVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조회</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css?version=${System.currentTimeMillis()}" />
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
			<div class="post">
				<c:choose>
					<c:when test="${category eq 'anonym'}">
						<div style="font-size: 1.3em; font-weight: bolder; color: black;">익명게시판
						</div>
					</c:when>
					<c:when test="${category eq 'general'}">
						<div style="font-size: 1.3em; font-weight: bolder; color: black;">자유게시판
						</div>
					</c:when>
					<c:when test="${category eq 'notice'}">
						<div style="font-size: 1.3em; font-weight: bolder; color: black;">공지사항
						</div>
					</c:when>
				</c:choose>
				<br>
				<div class="p">
					<div id="p" style="font-weight: bolder">${read.title}</div>
					<div id="p">
						<span style="display: flex;">${read.writer}<c:if
								test="${loginMember!=null && loginMember.member_id eq 'manager'}">
								<a title="${read.writer_id}">⚙</a>
							</c:if>&nbsp;|&nbsp;${read.post_date}&nbsp;|&nbsp;👀
							${read.view_count}&nbsp;|&nbsp;No. ${read.post_num} <c:if
								test="${(loginMember!=null) && !(loginMember.member_id eq read.writer_id)}">
								<form action="/board/report" method="get">
									<input type="hidden" name='post_num' value="${read.post_num}"><input
										type="hidden" name='reported_user' value="${read.writer}">
									<input type="hidden" name='reported_user_id'
										value="${read.writer_id}">
									<button id="heartBtn" type="submit" title="신고하기"
										style="border: none; background-color: #f8f8f8; font-size: 1em;">🚨
									</button>

								</form>
							</c:if>
						</span>
					</div>
					<div id="c">${read.content}</div>
					<div id="p" style="display: flex;">
						<c:if
							test="${(loginMember!=null) && !(loginMember.member_id eq read.writer_id)}">
							<form action="/board/heart" method="get">
								<input type="hidden" name='post_num' value="${read.post_num}">
								<input type="hidden" name='writer_id' value="${read.writer_id}">
								<input type="hidden" name='member_id'
									value="${loginMember.member_id}">
								<button id="heartBtn" type="submit" title="하트 보내기"
									style="border: none; background-color: #f8f8f8; font-size: 1em; height: 1px;">💓</button>
							</form>
						</c:if>
						&nbsp; 하트 ${read.heart_count}개
					</div>
					<hr style="height: 0.1px; width: 95%;">
					&nbsp;&nbsp;&nbsp;&nbsp;댓글 ${read.reply_count}개 📝
					<div id="p" style="color: black; font-size: 0.9em;">
						<c:choose>
							<c:when test="${reply.size()!=0}">
								<c:forEach var="re" items="${reply}">
									<div id="reply">
										&nbsp;&nbsp;&nbsp;${re.writer}: ${re.content}
										(${re.reply_date})
										<c:if
											test="${loginMember!=null && loginMember.member_id eq re.writer_id}">
											<form name="formDelRe" method="get" action="/board/delReply"
												encType="UTF-8">
												<input type="hidden" name='writer_id'
													value="${re.writer_id}"> <input type="hidden"
													name='post_num' value="${re.post_num}"> <input
													type="hidden" name='reply_num' value="${re.reply_num}">
												<button type="submit"
													style="width: 1px; height: 1px; background-color: rgba(0, 0, 0, 0); border: none;">(x)</button>
											</form>
										</c:if>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div id="reply">&nbsp;&nbsp;&nbsp;아직 댓글이 없습니다.</div>
							</c:otherwise>
						</c:choose>
						<c:if test="${loginMember!=null}">
							<c:set var="reWriter" value="${loginMember.member_name}" />
							<c:if test="${category eq 'anonym'}">
								<c:set var="reWriter" value="익명" />
							</c:if>
							<form class="reply" action="/board/reply" method="post">
								<input type="hidden" value="${read.category}" name='category'>
								<input type="hidden" value="${read.post_num}" name='post_num'>
								<input type="hidden" value="${loginMember.member_id}"
									name='writer_id'> <input type="hidden"
									value="${reWriter}" name='writer'> <input
									name='content' placeholder=" (댓글 작성)">
								<button type="submit">등록</button>
							</form>
						</c:if>
					</div>
				</div>
				<div id="edl">
					<c:if
						test="${loginMember!=null && loginMember.member_id eq read.writer_id}">
						<button
							onclick="location.href='/board/edit?post_num=${read.post_num}'">수정</button>
						<form name="formDelete" action="/board/delete" method="get"
							encType="UTF-8">
							<input type="hidden" name='writer_id' value="${read.writer_id}">
							<input type="hidden" name='post_num' value="${read.post_num}">
							<button type="submit">삭제</button>
						</form>
					</c:if>
					<button
						onclick="location.href='/board/${category}?currentPage=${currentPage}'">목록</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>