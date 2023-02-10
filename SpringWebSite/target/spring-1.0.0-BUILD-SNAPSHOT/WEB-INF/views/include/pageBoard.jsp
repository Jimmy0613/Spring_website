<%@page import="com.cre.domain.PageVO"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
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
	int currentPage = (Integer) request.getAttribute("currentPage");
	String cgp = (String) request.getAttribute("category");
	PageVO pvo = (PageVO) request.getAttribute("page");
	pvo.getPage(currentPage);
	int totalPage = pvo.getTotalPage();
	int currentPageBlock = pvo.getCurrentPageBlock();
	//(처음) 관련================================================
	if (currentPage > 1) {
	%>
	<a href="/board/list?category=<%=cgp%>"
		style="font-weight: bolder; font-size: 0.8em;">처음</a>
	<%
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">처음</a>
	<%
	}
	//========================================================
	//(이전) 관련================================================
	if (currentPage > 1) {
	if (currentPage % PageVO.PAGE_BLOCK == 1) {
	%>
	<a
		href="/board/list?category=<%=cgp%>&currentPage=<%=((currentPageBlock - 1) * PageVO.PAGE_BLOCK)%>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	} else if (currentPage > 1) {
	%>
	<a
		href="/board/list?category=<%=cgp%>&currentPage=<%=(currentPage - 1)%>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	}
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">이전</a>
	<%
	}
	//=========================================================
	for (int i = (currentPageBlock - 1) * PageVO.PAGE_BLOCK
			+ 1; i < ((currentPageBlock - 1) * PageVO.PAGE_BLOCK + PageVO.PAGE_BLOCK + 1) && i <= totalPage; i++) {
	%>
	<%
	if (i == currentPage) {
	%>
	<a style="font-weight: bolder;"
		href="/board/list?category=<%=cgp%>&currentPage=<%=i%>"><%=i%></a>
	<%
	} else {
	%>
	<a href="/board/list?category=<%=cgp%>&currentPage=<%=i%>"><%=i%></a>
	<%
	}
	}

	//(다음) 관련 ===============================================
	if (currentPage % PageVO.PAGE_BLOCK == 0 && currentPage < totalPage) {
	%>
	<a
		href="/board/list?category=<%=cgp%>&currentPage=<%=(currentPageBlock * PageVO.PAGE_BLOCK + 1)%>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else if (currentPage < totalPage) {
	%>
	<a
		href="/board/list?category=<%=cgp%>&currentPage=<%=currentPage + 1%>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">다음</a>
	<%
	}
	//===========================================================
	//(마지막) 관련================================================
	if (currentPage < totalPage) {
	%>
	<a href="/board/list?category=<%=cgp%>&currentPage=<%=totalPage%>"
		style="font-weight: bolder; font-size: 0.8em;">마지막</a>
	<%
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor: default;">마지막</a>
	<%
	}
	//========================================================
	%>
</body>
</html>