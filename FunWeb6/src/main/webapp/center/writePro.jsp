<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/writePro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");
// request 태그 파라미터 가져오기 name,pass,subject,content
// readcount<- 0 ,date <- 시스템날짜시간 
String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
int readcount=0;
Timestamp date=new Timestamp(System.currentTimeMillis());

// 패키지 board 파일이름 BoardBean 만들기  
// 멤버변수 set get 메서드 만들기

// BoardBean bb 객체생성 
BoardBean bb=new BoardBean();
// set메서드 호출 파라미터 값 저장
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadcount(readcount);
bb.setDate(date);

// 패키지 board 파일이름 BoardDAO 만들기  
// 리턴값없음 insertBoard(BoardBean bb) 메서드 만들기
// BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
// insertBoard(bb) 메서드 호출
bdao.insertBoard(bb);
// notice.jsp 이동
response.sendRedirect("../center/notice.jsp");
%>
</body>
</html>





