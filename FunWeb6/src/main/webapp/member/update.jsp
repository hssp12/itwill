<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
               
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
            }
        }).open();
    }
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더 들어가는곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더 들어가는곳 -->
  
<!-- 본문들어가는 곳 -->
  <!-- 본문 메인 이미지 -->
  <div id="sub_img_member"></div>
  <!-- 왼쪽 메뉴 -->
  <nav id="sub_menu">
  	<ul>
  		<li><a href="#">Join us</a></li>
  		<li><a href="#">Privacy policy</a></li>
  	</ul>
  </nav>
  <!-- 본문 내용 -->
  <%
  // 세션값 가져오기
  String id=(String)session.getAttribute("id");
  // 세션값이 없으면(로그인 되지 않았으면) login.jsp이동
  if(id==null){
	  response.sendRedirect("../member/login.jsp");
  }
  // MemberDAO mdao 객체생성
  MemberDAO mdao=new MemberDAO();
  // 리턴할형 MemberBean  getMember(String id) 메서드 정의
  // MemberBean mb = getMember(id) 메서드 호출
  MemberBean mb =mdao.getMember(id);
  %>
  <article>
  	<h1>Update Us</h1>
  	<form action="updatePro.jsp" method="post" id="join">
  		<fieldset>
  			<legend>Basic Info</legend>
  			<label>User Id</label>
  			<input type="text" name="id" class="id" value="<%=mb.getId()%>" readonly>
  			<input type="button" value="중복확인" class="dup"><br>
  			
  			<label>Password</label>
  			<input type="password" name="pass"><br>
  			
  			<label>Name</label>
  			<input type="text" name="name" value="<%=mb.getName()%>"><br>
  			
  			<label>E-Mail</label>
  			<input type="email" name="email" value="<%=mb.getEmail()%>"><br>
  			
  		</fieldset>
  		
  		<fieldset>
  			<legend>Optional</legend>
  			<label>Address</label>
  			<input type="text" name="address" id="sample6_address" value="<%=mb.getAddress()%>">
  			<input type="button" value="검색" class="dup" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
  			<label>Phone Number</label>
  			<input type="text" name="phone" value="<%=mb.getPhone()%>"><br>
  			<label>Mobile Phone Number</label>
  			<input type="text" name="mobile" value="<%=mb.getMobile()%>"><br>
  		</fieldset>
  		<div class="clear"></div>
  		<div id="buttons">
  			<input type="submit" value="Submit" class="submit">
  			<input type="reset" value="Cancel" class="cancel">
  		</div>
  	</form>
  </article>
  
  
<div class="clear"></div>  
<!-- 푸터 들어가는곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는곳 -->
</div>
</body>
</html>


