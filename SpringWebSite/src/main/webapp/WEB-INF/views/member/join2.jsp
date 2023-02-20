<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/resources/join.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/resources/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/resources/css/join.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<script type="text/javascript">
	function fn_joinMember() {
		var joinForm = document.joinForm;
		if (joinForm.idDuplication.value != "idCheck") {
			alert("아이디 중복체크를 해주세요.");
		} else {
			joinForm.method = "post";
			joinForm.action = "${contextPath}/member/join2";
			joinForm.submit();
		}
	}

	function fn_dbCheckId() {
		var joinForm = document.joinForm;
		var member_id = joinForm.member_id.value;
		if (member_id.length == 0 || member_id == "") {
			alert("아이디를 입력해주세요.");
			joinForm.member_id.focus();
		} else if (member_id.length < 6) {
			alert("아이디는 6글자 이상 입력해주세요.");
			joinForm.member_id.focus();
		} else {
			window.open("${contextPath}/member/idCheck.do?member_id="
					+ member_id, "", "width=500, height=300");
		}
	}

	function inputIdChk() {
		var joinForm = document.joinForm;
		var dbCheckId = document.joinForm.dbCheckId;
		document.joinForm.idDuplication.value = "idUncheck";
		dbCheckId.disabled = false;
		dbCheckId.style.opacity = 1;
		dbCheckId.style.cursor = "pointer";
	}
</script>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu"><%@include
					file="/WEB-INF/views/include/menuTop.jsp"%></div>
		</div>
		<div class="content">
			<div class="join">
				<span style="font-size: 1.2em;">회원가입</span>
				<div class="join_m">
					<form name="joinForm" action="/member/join" method="post">
						<input type="hidden" name="location" value="${location}">
						아이디: <input type="text" name='member_id' placeholder=" 6~12자"
							maxlength="12" onkeydown="inputIdChk()" />
						<button type="button" onclick="fn_dbCheckId()" name="dbCheckId">중복확인</button>
						<input type="hidden" name="idDuplication" value="idUncheck" /> <br>
						비밀번호: <input name='password' type="password" placeholder="8~14자"
							maxlength="14" required><br> 비밀번호 확인: <input
							name="pwCheck" type="password" placeholder="8~14자" maxlength="14"
							required><br>이름: <input name='member_name'
							placeholder=" 2~6자" required><br> 이메일: <input
							name='email' type="email" placeholder=" (선택)"><br>
						<button onclick="fn_joinMember()">가입하기</button>
						<a href="/member/login?location=/"> 로그인 </a>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>