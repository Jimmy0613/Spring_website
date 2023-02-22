<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib
	uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/list.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/search.css?version=${System.currentTimeMillis()}" />
<script type="text/javascript">
	function openPost(url) {
		window.open(url, "_blank", "left=100px, width=1000, height=1000");
	}
</script>
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
				<%@include file="/WEB-INF/views/include/menuLeft.jsp"%>
			</div>
			<div class="list">
				<div style="font-size: 1.3em; font-weight: bolder; color: black;">검색</div>
				<br>
				<div id="search">
					<form name="searchForm" action="/board/search">
						<input type="hidden" name="currentPage" value="1"> <span><select
							name='key'>
								<option value="all"
									<c:if test="${svo.key eq 'all'}">selected="selected"</c:if>>전체</option>
								<option value="title"
									<c:if test="${svo.key eq 'title'}">selected="selected"</c:if>>제목</option>
								<option value="content"
									<c:if test="${svo.key eq 'content'}">selected="selected"</c:if>>내용</option>
								<option value="writer"
									<c:if test="${svo.key eq 'writer'}">selected="selected"</c:if>>작성자</option>
						</select> <select name='category'>
								<option value="all"
									<c:if test="${svo.category eq 'all'}">selected="selected"</c:if>>전체</option>
								<option value="general"
									<c:if test="${svo.category eq 'general'}">selected="selected"</c:if>>자유</option>
								<option value="anonym"
									<c:if test="${svo.category eq 'anonym'}">selected="selected"</c:if>>익명</option>
						</select> <input name='keyword' value="${svo.keyword}">
							<button type="submit">검색</button> </span>
					</form>
				</div>
				<div class="list_s">
					<div class="list_n" style="color: black;">
						<div>게시판</div>
						<div>작성자</div>
						<div>제목</div>
						<div>♡</div>
						<div>조회수</div>
						<hr>
					</div>
					<div class="list_z">
						<c:choose>
							<c:when test="${list.size()!=0}">
								<c:forEach var="s" items="${list}">
									<div class="list_n" style="background-color: white;">
										<c:choose>
											<c:when test="${s.category eq 'anonym'}">
												<div>익명</div>
												<div>익명</div>
											</c:when>
											<c:otherwise>
												<div>자유</div>
												<div>${s.writer}</div>
											</c:otherwise>
										</c:choose>
										<div id="t">
											<c:set var="title" value="${s.title}" />
											<c:if test="${fn:length(s.title)>10}">
												<c:set var="title" value="${fn:substring(s.title,0,10)}..." />
											</c:if>
											<c:if test="${s.reply_count>0}">
												<c:set var="title" value="${title} (${s.reply_count})" />
											</c:if>
											<a style="cursor: pointer;" title="${s.title}"
												onclick="openPost('/board/read?post_num=${s.post_num}')">${title}</a>
										</div>
										<div>${s.heart_count}</div>
										<div>${s.view_count}</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
							검색 결과가 없습니다.
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="page">
					<c:if test="${list.size()!=0}">
						<%@include file="/WEB-INF/views/include/page/pageSearch.jsp"%>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>