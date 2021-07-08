<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/updatePro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");
// request 태그파라미터 가져오기 
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String address=request.getParameter("address");
String phone=request.getParameter("phone");
String mobile=request.getParameter("mobile");



//MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// MemberBean mb = userCheck(id,pass) 메서드호출
MemberBean mb=mdao.userCheck(id, pass);

if(mb!=null){
	// mb null아니면 아이디 비밀번호 일치  update
	
    //MemberBean mb2 객체생성 => 기억장소 할당
    MemberBean mb2=new MemberBean();
    //mb2주소를 통해서 set메서드 호출해서 
    // 태그파라미터(폼에서 수정할 정보를 들고옴) 값 저장
    mb2.setId(id);
    mb2.setPass(pass);
    mb2.setName(name);
    mb2.setEmail(email);
    mb2.setAddress(address);
    mb2.setPhone(phone);
    mb2.setMobile(mobile);
    
//  리턴할형없음 updateMember(MemberBean mb2)메서드 정의
//  updateMember(mb2) 메서드 호출
mdao.updateMember(mb2);
//  ../main/main.jsp 이동
response.sendRedirect("../main/main.jsp");
}else{
//  이면  아이디 비밀번호 틀림 "입력하신 정보가 틀림" 뒤로이동
	%>
	<script type="text/javascript">
		alert("입력하신 정보가 틀림");
		history.back();
	</script>
	<%
}
%>
</body>
</html>





