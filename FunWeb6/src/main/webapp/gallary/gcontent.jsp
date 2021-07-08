<%@page import="board.gallaryDAO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fwrite.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더 들어가는곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 들어가는곳 -->
  
<!-- 본문들어가는 곳 -->
  <!-- 본문 메인 이미지 -->
  <div id="sub_img_center"><img src="../images/hotel5.jpg"></div>
  <!-- 왼쪽 메뉴 -->
  <nav id="sub_menu">
  	<ul>
  		<li><a href="../center/notice.jsp">Notice</a></li>
  		<li><a href="#">Public News</a></li>
  		<li><a href="../fcenter/fnotice.jsp">Driver Download</a></li>
  		<li><a href="../gallary/gallary.jsp">Gallery</a></li>
  	</ul>
  </nav>
  <!-- 본문 내용 -->
  <%
//http://localhost:8080/FunWeb/center/content.jsp?num=13
//int  num 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
// FileBoardDAO bdao 객체생성
gallaryDAO gdao=new gallaryDAO();
// 조회수 1증가 수정 readcount = readcount+1 조건 num=?
gdao.gupdateReadcount(num);		

// BoardBean bb  =  fgetBoard(num)
BoardBean bb=gdao.ggetBoard(num);
  %>
  <article>
  	<h1>File Notice Content</h1>
  	<table id="notice">


    <td colspan="3"><%=bb.getSubject() %></td></tr>

    <td colspan="3"><img src="../upload/picture/<%=bb.getFile()%>" width="500" height="450"></td></tr>    

    <td colspan="3"><%=bb.getContent() %></td></tr>
  	</table>
  	
  	<div id="table_search">
  	<%
  	// 세션값 가져오기
  	String id=(String)session.getAttribute("id");
  	// 로그인 (세션값이 있으면) 되어있으면
  	if(id != null){
// 로그인한 아이디(세션) , 글쓴 아이디 => 일치하면 글수정,글삭제 보임
		if(id.equals(bb.getName())){
  		%>
  	  	<input type="button" value="글수정" class="btn"
  		onclick="location.href='fupdate.jsp?num=<%=bb.getNum()%>'">
  		<input type="button" value="글삭제" class="btn"
  		onclick="location.href='fdelete.jsp?num=<%=bb.getNum()%>'">  		
  		<%
		}
  	}
  	%>
  		
  		<input type="button" value="글목록" class="btn"
  		onclick="location.href='gallary.jsp'">
  	</div>
  	
  	<div class="clear"></div> 
  </article>
  
<div class="clear"></div>  
<!-- 푸터 들어가는곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는곳 -->
</div>
</body>
</html>


