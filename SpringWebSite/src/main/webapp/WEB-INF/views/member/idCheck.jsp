<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="member_id" value="${param.member_id}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 확인</title>
<script type="text/javascript">
	function sendCheckValue() {
		var openJoinForm = opener.document.joinForm;
		if (document.checkIdForm.chResult.value == "N") {
			alert("다른 아이디를 입력해주세요.");
			openJoinForm.id.focus();
			window.close();
		} else {
			openJoinForm.idDuplication.value = "idCheck";
			openJoinForm.dbCheckId.disabled = true;
			openJoinForm.dbCheckId.style.opacity = 0.6;
			openJoinForm.dbCheckId.style.cursor = "default";
			window.close();
		}
	}
</script>
</head>
<body>
	<b><font size="4" color="gray">아이디 중복 확인</font></b>
	<br>

	<form name="checkIdForm">
		<input type="text" name="member_id" value="${member_id}" disabled>
		<c:choose>
			<c:when test="${result==1}">
				<p style="color: red">이미 사용 중인 아이디입니다.</p>
				<input type="hidden" name="chResult" value="N" />
			</c:when>
			<c:when test="${result==0}">
				<p style="color: blue">사용할 수 있는 아이디입니다.</p>
				<input type="hidden" name="chResult" value="Y" />
			</c:when>
		</c:choose>
		<input type="button" onclick="window.close()" value="취소" /> <input
			type="button" onclick="sendCheckValue()" value="사용하기" />
	</form>
</body>
</html>