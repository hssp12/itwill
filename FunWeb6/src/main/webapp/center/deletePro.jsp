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
int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// bdao.deleteBoard(num);
bdao.deleteBoard(num);
// notice.jsp 이동
response.sendRedirect("notice.jsp");
%>
</body>
</html>




