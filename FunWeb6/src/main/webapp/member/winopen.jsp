<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/winopen.jsp</title>
<script type="text/javascript">
	function result() {
		// join.jsp 아이디상자 <= winopen.jsp 찾은아이디값 넣기
		// window.opener 멤버변수 창을 열게해준 정보를 저장하는 변수
		opener.document.fr.id.value = document.wfr.id.value;
		// 창닫기
		window.close();
	}
</script>
</head>
<body>
<%
// request 요청정보 저장 파라미터(id) 가져오기
String id=request.getParameter("id");
// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// MemberBean mb = getMember(id) 메서드 호출
MemberBean mb=mdao.getMember(id);
// mb가 null아니면 아이디 있음 out.println("아이디 중복") 
//          이면  아이디 없음  out.println("아이디 사용가능")
if(mb!=null){
	// 아이디 있음
	out.println("아이디 중복");
}else{
	// 아이디 없음
	out.println("아이디 사용가능");
	%>
	<input type="button" value="아이디사용" onclick="result()">
	<%
}
%>
<form action="winopen.jsp" method="post" name="wfr">
	아이디 <input type="text" name="id" value="<%=id%>"><br>
	<input type="submit" value="아이디찾기">
</form>
</body>
</html>





