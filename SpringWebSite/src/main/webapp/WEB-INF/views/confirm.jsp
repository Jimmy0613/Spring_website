<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>확인</title>
</head>
<body>
	<script>
		var msg = "<c:out value='${msg}'/>";
		var url_yes = "<c:out value='${url_yes}'/>";
		var url_no = "<c:out value='${url_no}'/>";
		if (confirm(msg)) {
			location.href = url_yes;
		} else {
			location.href = url_no;
		}
	</script>
</body>
</html>