<%@page import="com.cre.domain.PageVO"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
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
	<c:set var="p" value="${page}" />
	${p.getPage(currentPage)}
	<c:set var="totalPage" value="${p.getTotalPage()}" />
	<c:set var="currentPageBlock" value="${p.getCurrentPageBlock()}" />
	<!-- //(처음) 관련================================================ -->
	<c:choose>
		<c:when test="${currentPage>1}">
			<a href="/board/${category}"
				style="font-weight: bolder; font-size: 0.8em;">처음</a>
		</c:when>
		<c:otherwise>
			<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">처음</a>
		</c:otherwise>
	</c:choose>
	<!-- (이전) 관련================================================ -->
	<c:choose>
		<c:when test="${currentPage>1}">
			<c:choose>
				<c:when test="${currentPage%PageVO.PAGE_BLOCK==1}">
					<a
						href="/board/${category}?currentPage=${((currentPageBlock - 1) * PageVO.PAGE_BLOCK)}"
						style="font-weight: bolder; font-size: 0.8em;">이전</a>
				</c:when>
				<c:otherwise>
					<a href="/board/${category}?currentPage=${(currentPage - 1)}"
						style="font-weight: bolder; font-size: 0.8em;">이전</a>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">이전</a>
		</c:otherwise>
	</c:choose>
	
	<!-- 페이지 표시 -->
	<c:set var="stop" value="false" />
	<c:forEach var="i"
		begin="${(currentPageBlock - 1) * PageVO.PAGE_BLOCK
				+ 1}"
		end="${((currentPageBlock - 1) * PageVO.PAGE_BLOCK + PageVO.PAGE_BLOCK)}"
		step="1">
		<c:if test="${not stop}">
			<c:if test="${i==totalPage}">
				<c:set var="stop" value="true" />
			</c:if>
			<c:choose>
				<c:when test="${i==currentPage}">
					<a style="font-weight: bolder;"
						href="/board/${category}?currentPage=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="/board/${category}?currentPage=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>
	
	<!-- //(다음) 관련 =============================================== -->
	<c:choose>
		<c:when
			test="${currentPage % PageVO.PAGE_BLOCK == 0 && currentPage < totalPage}">
			<a
				href="/board/${category}?currentPage=${(currentPageBlock * PageVO.PAGE_BLOCK + 1)}"
				style="font-weight: bolder; font-size: 0.8em;">다음</a>
		</c:when>
		<c:when test="${currentPage < totalPage}">
			<a href="/board/${category}?currentPage=${currentPage + 1}"
				style="font-weight: bolder; font-size: 0.8em;">다음</a>
		</c:when>
		<c:otherwise>
			<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">다음</a>
		</c:otherwise>
	</c:choose>
	<!-- //(마지막) 관련================================================ -->
	<c:choose>
		<c:when test="${currentPage<totalPage}">
			<a href="/board/${category}?currentPage=${totalPage}"
				style="font-weight: bolder; font-size: 0.8em;">마지막</a>
		</c:when>
		<c:otherwise>
			<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">마지막</a>
		</c:otherwise>
	</c:choose>
</body>
</html>