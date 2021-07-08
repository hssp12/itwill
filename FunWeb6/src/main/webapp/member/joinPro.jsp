<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/joinPro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");
// request 태그파라미터값 가져오기
// id,pass,name,email,address,phone,mobile 
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String address=request.getParameter("address");
String phone=request.getParameter("phone");
String mobile=request.getParameter("mobile");
// date 현시스템 날짜시간 가져오기
Timestamp date=new Timestamp(System.currentTimeMillis());

// 회원가입할 내용을 MemberBean 바구니 저장
// 패키지(폴더) member 파일이름 MemberBean
// id,pass,name,date,email,address,phone,mobile 멤버변수
// set, get메서드 

// MemberBean mb 객체생성 => 기억장소 할당
MemberBean mb=new MemberBean();
// mb주소를 통해서 set메서드 호출해서 태그파라미터 값 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setDate(date);
mb.setEmail(email);
mb.setAddress(address);
mb.setPhone(phone);
mb.setMobile(mobile);


// 패키지(폴더) member 파일이름 MemberDAO
// 리턴값 없음 insertMember(MemberBean mb 바구니주소) 메서드정의

// MemberDAO mdao 객체생성 => 기억장소 할당
MemberDAO mdao=new MemberDAO();
// insertMember(mb 바구니주소) 메서드 호출
mdao.insertMember(mb);

// 회원가입 축하 메일 보내기
// mailSend.jsp 내용
String sender="관리자(구글계정) 이메일주소";
String receiver="회원가입하는 회원의 이메일주소";
String subject="회원가입축하";
String content="회원가입 축하드리면 많은 활동 부탁드립니다.";

// mailSend.jsp try 내용 넣어서 메일 보내기
%>
<script type="text/javascript">
	alert("회원가입성공");
	location.href="login.jsp";
</script>
</body>
</html>




