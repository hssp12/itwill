<%@page import="board.FileBoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
// request.setCharacterEncoding("utf-8");
String uploadpath=request.getRealPath("/upload");
int maxSize=10*1024*1024;

MultipartRequest multi = new MultipartRequest(request,uploadpath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// request 태그파라미터 가져오기 num name subject content
int num=Integer.parseInt(multi.getParameter("num"));
String name=multi.getParameter("name");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
String file = multi.getFilesystemName("file");

if(file == null){
	file=multi.getParameter("oldfile");
}

// BoardBean bb 객체생성
BoardBean bb=new BoardBean();
// set메서드 호출 멤버변수에 파라미터값 저장
bb.setNum(num);
bb.setName(name);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);

// BoardDAO bdao 객체생성
FileBoardDAO bdao=new FileBoardDAO();
// updateBoard(bb) 메서드 호출
bdao.guestinsertBoard(bb);
// notice.jsp 이동
response.sendRedirect("fcontent.jsp");
%>
</body>
</html>






