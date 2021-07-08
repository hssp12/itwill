<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/updatePro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");
// request 태그파라미터 가져오기 num name subject content
int num=Integer.parseInt(request.getParameter("num"));
String name=request.getParameter("name");
String subject=request.getParameter("subject");
String content=request.getParameter("content");

// BoardBean bb 객체생성
BoardBean bb=new BoardBean();
// set메서드 호출 멤버변수에 파라미터값 저장
bb.setNum(num);
bb.setName(name);
bb.setSubject(subject);
bb.setContent(content);

// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// updateBoard(bb) 메서드 호출
bdao.updateBoard(bb);
// notice.jsp 이동
response.sendRedirect("notice.jsp");
%>
</body>
</html>






