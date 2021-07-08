<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
String id = (String)session.getAttribute("id");

MemberDAO mdao = new MemberDAO();

MemberBean mb = mdao.getMember(id);
%>
<form action="updatePro.jsp" method="get">
아이디 : <input type="text" name="id" value="<%=mb.getId()%>" readonly><br>
비밀번호 : <input type="password" name="pass"><br>
이름 : <input type="text" name="name" value="<%=mb.getName()%>"><br>
이메일: <input type="text" name="email" value="<%=mb.getEmail()%>"><br>
주소: <input type="text" name="address" value="<%=mb.getAddress()%>"><br>
전화번호:<input type="text" name="phone" value="<%=mb.getPhone()%>"><br>
핸드폰번호:<input type="text" name="mobile" value="<%=mb.getMobile()%>"><br>
<input type="submit" value="회원수정">
</form>	
</body>
</html>