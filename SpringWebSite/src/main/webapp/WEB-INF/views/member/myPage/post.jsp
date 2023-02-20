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
<title>내가 쓴 글</title>
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
					<span id="t">내가 쓴 글</span> <br>
					<div class="list">
						<div class="list_m">
							<div class="list_n" style="background-color: white;">
								<div>게시판</div>
								<div>제목</div>
								<div>♡</div>
								<div>조회수</div>
								<hr>
							</div>
							<div class="list_z">
								<c:choose>
									<c:when test="${myPost.size()>0}">
										<c:forEach var="p" items="${myPost}">
											<div class="list_n">
												<c:choose>
													<c:when test="${p.category eq 'anonym'}">
														<div>익명게시판</div>
													</c:when>
													<c:when test="${p.category eq 'general'}">
														<div>자유게시판</div>
													</c:when>
													<c:otherwise>
														<div>공지사항</div>
													</c:otherwise>
												</c:choose>
												<c:set var="t" value="${p.title}" />
												<c:if test="${p.reply_count>0}">
													<c:set var="t" value="${p.title} (${p.reply_count})">
													</c:set>
												</c:if>
												<div style="text-align: left;">
													<a
														href="/board/read?post_num=${p.post_num}&category=${p.category}">${t}
													</a>
												</div>
												<div>${p.heart_count}</div>
												<div>${p.view_count}</div>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<div>작성한 글이 없습니다.</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="page">
								<%@ include file="/WEB-INF/views/include/page/pageMyPage.jsp"%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>