<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
  <!-- login join -->
  <%
  //  String id = 세션값 가져오기("id")
  String id=(String)session.getAttribute("id");
  if(id==null){
	// 세션값 없으면 (세션값이 null이면) login join
	%>
	<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
	<%
  }else{
     //    있으면    i     ..님 logout update  
     %>
     <div id="login"><%=id %> 님 | <a href="../member/logout.jsp">logout</a> | <a href="../member/update.jsp">update</a> | <a href="../member/delete.jsp">delete</a></div>
     <%
  }
  %>
  <div class="clear"></div>
  <!-- 로고들어가는 곳 -->
  <div id="logo"><img src="../images/logo6.png"></div>
  <!-- 메뉴들어가는 곳 -->
  <nav id="top_menu">
  	<ul>
  		<li><a href="../main/main.jsp">메인화면</a></li>
  		<li><a href="../company/welcome.jsp">호텔소개</a></li>
  		<li><a href="../company/welcome.jsp">프로모션</a></li>
  		<li><a href="../center/notice.jsp">공지사항</a></li>
  		<li><a href="../mail/mailForm.jsp">고객센터</a></li>
  	</ul>
  </nav>
</header>