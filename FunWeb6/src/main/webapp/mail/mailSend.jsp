<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="mailtest.GoogleAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mail/mailSend.jsp</title>
</head>
<body>
<%
//request 한글처리
request.setCharacterEncoding("utf-8");
//request 파라미터값 sender  receiver  subject content
String sender="hssp122@gmail.com";
String receiver="hssp12@daum.net";
String subject=request.getParameter("subject");
String content=request.getParameter("content");
try{
	// 메일보내는 서버 주소 설정
	// 서버정보를 Properties 객체 저장
	Properties properties=System.getProperties();
	properties.put("mail.smtp.starttls.enable", "true");
	//서버정보저장
	properties.put("mail.smtp.host", "smtp.gmail.com");
	//사용자 인증
	properties.put("mail.smtp.auth", "true");
	// gmail포트 설정
	properties.put("mail.smtp.port", "587");
	
	//인증정보를 생성하는 부분 패키지 mailtest 파일이름 GoogleAuthentication
	// GoogleAuthentication 객체생성
	Authenticator auth=new GoogleAuthentication();
	
	// 메일을 전송하는 역할하는 Session 객체생성
	Session s=Session.getDefaultInstance(properties,auth);
	
	// Session객체를 사용해서 Message객체생성
	Message message=new MimeMessage(s);
	
	// 보내는사람 정보를 저장
	Address sender_address=new InternetAddress(sender);
	// 받는사람 정보를 저장
	Address receiver_address=new InternetAddress(receiver);
	message.setHeader("content-type","text/html;charset=UTF-8");
	message.setFrom(sender_address);
	message.addRecipient(Message.RecipientType.TO, receiver_address);
	// 제목,내용 , 보내는 시간 정보를 저장
	message.setSubject(subject);
	message.setContent(content,"text/html;charset=UTF-8");
	message.setSentDate(new Date());
	// 전송
	Transport.send(message);
	
	out.println("메일이 정상적으로 발송되었습니다.");
}catch(Exception e){
	out.println("SMTP서버가 잘못 설정되었거나, 서비스에 문제 발생");
	e.printStackTrace();
}
response.sendRedirect("../main/main.jsp");
%>

</body>
</html>






