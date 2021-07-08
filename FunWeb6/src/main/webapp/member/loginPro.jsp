<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// request id,pass 태그파라미터 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");
// 리턴할형 MemberBean  userCheck(String id,String pass) 메서드정의

//MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// MemberBean mb = userCheck(id,pass) 메서드호출
MemberBean mb=mdao.userCheck(id, pass);
// mb null아니면 아이디 비밀번호 일치  세션값생성 "id",id
//        이면  아이디 비밀번호 틀림 "입력하신 정보가 틀림" 뒤로이동
if(mb!=null){
	session.setAttribute("id", id);
	response.sendRedirect("../main/main.jsp");
}else{
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



