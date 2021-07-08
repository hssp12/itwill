<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/logout.jsp</title>
</head>
<body>
<%
//세션값 초기화
session.invalidate();
// login.jsp 이동
%>
<script type="text/javascript">
	alert("로그아웃");
	location.href="../member/login.jsp";
</script>
</body>
</html>





