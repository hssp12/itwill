<%@page import="board.gallaryDAO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fwritePro.jsp</title>
</head>
<body>
<%
// request 한글처리
// request.setCharacterEncoding("utf-8");
// cos.jar 프로그램 설치
// upload 폴더 만들기
String uploadPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;

MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// request 태그 파라미터 가져오기 name,pass,subject,content
// readcount<- 0 ,date <- 시스템날짜시간 
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
int readcount=0;
Timestamp date=new Timestamp(System.currentTimeMillis());
// file추가
String file=multi.getFilesystemName("file");

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
// file추가
bb.setFile(file);

// 패키지 board 파일이름 FileBoardDAO 만들기  
// 리턴값없음 finsertBoard(BoardBean bb) 메서드 만들기
// FileBoardDAO bdao 객체생성
gallaryDAO gdao=new gallaryDAO();
// insertBoard(bb) 메서드 호출
gdao.ginsertBoard(bb);
// fnotice.jsp 이동
response.sendRedirect("../gallary/gallary.jsp");
%>
</body>
</html>





