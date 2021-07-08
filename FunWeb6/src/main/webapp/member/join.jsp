<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	$('#join').submit(function () {
		var id = $('#id').val();
		var pass = $('#pass').val();
		var name = $('#name').val();
		var email = $('#email').val();
		if(id == ""){
			alert('아이디입력');
			$('#id').focus();
			return false;
		}
		if(pass == ""){
			alert('비밀번호입력');
			$('#pass').focus();
			return false;
		}
		if(name == ""){
			alert('이름입력');
			$('#name').focus();
			return false;
		}
		if(email == ""){
			alert('이메일입력');
			$('#email').focus();
			return false;
		}
	});
});
</script>

<script type="text/javascript">
	function submit() {
		alert("회원가입완료");
	}
	function winopen() {
// 		alert("아이디 중복체크");
		if(document.fr.id.value==""){
			// 아이디 입력하세요 메시지
			alert("아이디 입력하세요");
			// 포커스 
			document.fr.id.focus();
			// 리턴
			return;
		}
		// 창열기 
// 		document.open(열고자하는 파일이름,창이름,창옵션);
		var id=document.fr.id.value;
		document.open("winopen.jsp?id="+id,"","width=400,height=300");
	}
	
</script>
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                 
                }

               
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
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
  <article>
  	<h1>Join Us</h1>
  	<form action="joinPro.jsp" method="post" id="join" name="fr">
  		<fieldset>
  			<legend>Basic Info</legend>
  			<label>User Id</label>
  			<input type="text" name="id" class="id" id="id">
  			<input type="button" value="중복 확인" class="dup" onclick="winopen()"><br>
  			
  			<label>Password</label>
  			<input type="password" name="pass" id="pass"><br>
  			<label>Retype Password</label>
  			<input type="password" name="pass2"><br>
  			
  			<label>Name</label>
  			<input type="text" name="name" id="name" ><br>
  			
  			<label>E-Mail</label>
  			<input type="email" name="email" id="email"><br>
  			
  			<label>Retype E-Mail</label>
  			<input type="email" name="email2" ><br>
  		</fieldset>
  		
  		<fieldset>
  			<legend>Optional</legend>
  			<label>Postal Code</label>
  			<input type="text"  id="sample6_postcode" placeholder="우편번호">
  			<input type="button" value="검색" class="dup" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
  			<label>Address</label><input type="text" name="address" id="sample6_address" placeholder="주소"><br>
  			<label>Phone Number</label>
  			<input type="text" name="phone" ><br>
  			<label>Mobile Phone Number</label>
  			<input type="text" name="mobile" ><br>
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


