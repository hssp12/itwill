<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mail/mailForm.jsp</title>
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
  <div id="sub_img_member"><img src="../images/hotel3.jpg"></div>
  <!-- 왼쪽 메뉴 -->
  <nav id="sub_menu">
  	<ul>
  		<li><a href="#">Join us</a></li>
  		<li><a href="#">Privacy policy</a></li>
  	</ul>
  </nav>
  <!-- 본문 내용 -->
  <article>
  	<h1>E-MAIL</h1>
  	<form action="mailSend.jsp" method="post"  id="join">
  	<fieldset>
<!-- <label>보내는 사람 <br></label> -->
<!--  <input type="text" name="sender"><br><br> -->
<!-- <label>받는 사람 <br></label> -->
<!-- <input type="text" name="receiver"><br><br> -->
<label>제목 : </label>
<input type="text" name="subject"><br>
<label>내용 : </label>
<textarea rows="20" cols="40" name="content"></textarea>
<br>
<div id="table_search">
<input type="submit" value="메일보내기" class="btn">
</div>
    </fieldset>
</form>
  </article>
  
  
<div class="clear"></div>  
<!-- 푸터 들어가는곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는곳 -->
</div>
</body>
</html>


