<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/write.jsp</title>
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
  <div id="sub_img_center"></div>
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
  // 세션값 가져오기
  String id=(String)session.getAttribute("id");
  // 세션값이 없으면 login.jsp 이동
  if(id==null){
	  response.sendRedirect("../member/login.jsp");
  }
  // update.jsp?num=
  // int num = num 파라미터 가져오기
  int num=Integer.parseInt(request.getParameter("num"));
  // BoardDAO bdao 객체생성
  BoardDAO bdao=new BoardDAO();
  // BoardBean bb = getBoard(num) 메서드 호출
  BoardBean bb=bdao.getBoard(num); 		  
  %>
  <article>
  	<h1>Notice Update</h1>
  	<form action="updatePro.jsp" method="post">
  	<input type="hidden" name="num" value="<%=num%>">
  	<table id="notice">
<tr><td >글쓴이</td>
    <td><input type="text" name="name" value="<%=id%>" readonly></td></tr>
<tr><td>제목</td>
    <td><input type="text" name="subject" value="<%=bb.getSubject() %>"></td></tr>
<tr><td>내용</td>
    <td><textarea rows="10" cols="20" name="content"><%=bb.getContent() %></textarea></td></tr>
  	</table>

  	<div id="table_search">
  		<input type="submit" value="글수정" class="btn">
  	</div>
  	</form>
  	<div class="clear"></div> 
  </article>
  
  
<div class="clear"></div>  
<!-- 푸터 들어가는곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는곳 -->
</div>
</body>
</html>


