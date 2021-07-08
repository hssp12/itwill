<%@page import="member.MemberDAO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/deletePro.jsp</title>
</head>
<body>
<%
//int num = num 파라미터 가져오기
// int num=Integer.parseInt(request.getParameter("num"));
String id=(String)session.getAttribute("id");
String pass = request.getParameter("pass");
// BoardDAO bdao 객체생성
MemberDAO mdao=new MemberDAO();
// bdao.deleteBoard(num);
mdao.deleteMember(id,pass);
// notice.jsp 이동
session.invalidate();
response.sendRedirect("login.jsp");
%>
</body>
</html>




