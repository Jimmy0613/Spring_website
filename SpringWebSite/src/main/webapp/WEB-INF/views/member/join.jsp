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

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css?version=${System.currentTimeMillis()}" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/join.css?version=${System.currentTimeMillis()}" />

<script type="text/javascript">
	function fn_joinMember() {
		var joinForm = document.joinForm;
		var password = joinForm.password.value;
		var pwCheck = joinForm.pwCheck.value;
		var member_name = joinForm.member_name.value;
		if (joinForm.idDuplication.value != "idCheck") {
			alert("아이디 중복체크를 해주세요.");
			joinForm.member_id.focus();
			return false;
		} else if (password.length < 8) {
			alert("비밀번호는 여덟 글자 이상 입력해주세요.");
			joinForm.password.focus();
			return false;
		} else if (pwCheck != password) {
			alert("비밀번호란과 비밀번호 확인란이 일치하지 않습니다.");
			joinForm.pwCheck.focus();
			return false;
		} else if (member_name.length < 2) {
			alert("이름은 두 글자 이상 입력해주세요.");
			joinForm.member_name.focus();
			return false;
		}
		joinForm.method = "get";
		joinForm.action = "${contextPath}/member/joinMember";
		joinForm.submit();

	}

	function fn_dbCheckId() {
		var joinForm = document.joinForm;
		var member_id = joinForm.member_id.value;

		if (member_id.length < 6) {
			alert("아이디는 여섯 글자 이상 입력해주세요.");
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
					<form name="joinForm" method="get" onsubmit="return false;">
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
						<a href="/member/login"> 로그인 </a>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>