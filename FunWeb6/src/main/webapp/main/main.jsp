<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더 들어가는곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 들어가는곳 -->
  
<div class="clear"></div>   
<!-- 본문들어가는 곳 -->
  <!-- 메인 이미지 -->
  <div id="main_img"><img src="../images/hotel2.jpg"></div>
  <!-- 본문 내용 -->
  <article id="front">
  	<div id="solution">
  		<div id="hosting">
  			<h3>Web Hosting Solution</h3>
			<p>Lorem impsun Lorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsun....</p>
  		</div>
  		<div id="security">
  		  	<h3>Web Security Solution</h3>
			<p>Lorem impsun Lorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsun....</p>
  		</div>
  		<div id="payment">
  			<h3>Web Payment Solution</h3>
			<p>Lorem impsun Lorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsunLorem impsun....</p>
  		</div>
  	</div>
  	
  	<div class="clear"></div>
 	
 	
 	  	<div id="sec_news">
<h3><span class="orange">Security</span> News</h3>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis anteProin 
quis ante......</dd>
</dl>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis anteProin 
quis ante......</dd>
</dl>
</div>


	<div id="news_notice">
  		<h3 class="brown">News &amp; Notice</h3>
  		<table>
  		<%
  		// 한화면에 보여줄 글개수 설정
  	  	int pageSize=5;
  		// 시작하는 행번호
  		int startRow=1;
  		// BoardDAO bdao 객체생성
  		BoardDAO bdao=new BoardDAO();
// List<BoardBean> boardList= getBoardList() 메서드 호출
		List<BoardBean> boardList=bdao.getBoardList(startRow, pageSize);
		// for 출력
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		for(int i=0;i<boardList.size();i++){
			BoardBean bb=boardList.get(i);
			%>
<tr><td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
    <td><%=sdf.format(bb.getDate()) %></td></tr>			
			<%
		}
  		%>
  		</table>
  	</div>
	
 	
  </article>
  
  
<div class="clear"></div>  
<!-- 푸터 들어가는곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는곳 -->
</div>
</body>
</html>


