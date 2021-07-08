<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fwrite.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">


	
	<title>방명록 답변</title>
	
	<style type="text/css">
		#wrap {
/* 			width: 550px; */
			text-align :center;
			margin: 50px auto 0 auto;
		}
	
		#writeReplyForm{
			text-align :center;
		}
	</style>
	
	<script type="text/javascript">
		function checkValue(){
			var form = document.forms[0];

			if(!form.guestbook_id.value)
			{
				alert("이름을 입력하세요.");
				return false;
			}
			else if(!form.guestbook_password.value)
			{
				alert("비밀번호를 입력하세요.");
				return false;
			}
			else if(!form.guestbook_content.value)
			{
				alert("내용을 입력하세요.");
				return false;
			}
			else
			{
				form.target = opener.name;
				form.method="post";
				form.action="GuestbookReplyAction.ge?page=${pageNum}";
				form.submit();

				if (opener != null) {
                	opener.rForm = null;
                	self.close();
				}
			}
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
  <div id="sub_img_center"></div>
  <!-- 왼쪽 메뉴 -->
  <nav id="sub_menu">
  	<ul>
  		<li><a href="../center/notice.jsp">Notice</a></li>
  		<li><a href="#">Public News</a></li>
  		<li><a href="../fcenter/fnotice.jsp">Driver Download</a></li>
  		<li><a href="../gallary/gallary.jsp">Gallery</a></li>
  	</ul>
  </nav>
  <!-- 본문 내용 -->
  <%
//http://localhost:8080/FunWeb/center/content.jsp?num=13
//int  num 파라미터 가져오기
int num=Integer.parseInt(request.getParameter("num"));
// FileBoardDAO bdao 객체생성
FileBoardDAO bdao=new FileBoardDAO();
// 조회수 1증가 수정 readcount = readcount+1 조건 num=?
bdao.fupdateReadcount(num);		

// BoardBean bb  =  fgetBoard(num)
BoardBean bb=bdao.fgetBoard(num);

//------------------------------------------
 int pageSize=5;
  // 현 페이지번호 가져오기 
  String pageNum=request.getParameter("pageNum");
  // 현 페이지번호가 없으면 1페이지로 설정
  if(pageNum == null){
	  pageNum="1";
  }
  int currentPage=Integer.parseInt(pageNum);
// pageNum(currentPage) pageSize조합해서 =>디비에 시작하는행번호를 구해서
//     1                 15            => (1-1)*15+1=>1행 		  
//     2                 15            => (2-1)*15+1=>16행
//     3                 15            => (3-1)*15+1=>31행
  int startRow=	(currentPage-1)*pageSize+1;	 
// 1~15  16~30 31~45
// startRow pageSize =>디비 끝 행번호 구하기
//     1      15     => 1+15-1=>15
//     16     15     => 16+15-1=>30
int endRow=startRow+pageSize-1;
//FileBoardDAO bdao 객체생성

//리턴할형 List<BoardBean> getBoardList(int startRow, int pageSize) 메서드 정의
//List<BoardBean> boardList=getBoardList(startRow,pageSize)메서드호출
List<BoardBean> boardList=bdao.guestgetBoardList(startRow, pageSize);
bdao.guestgetBoard(num);

  %>
  <article>
  	<h1>File Notice Content</h1>
  	<table id="notice">
<tr><td>글번호</td><td><%=bb.getNum() %></td>
    <td>글쓴이</td><td><%=bb.getName() %></td></tr>
<tr><td>글쓴날짜</td><td><%=bb.getDate() %></td>
    <td>조회수</td><td><%=bb.getReadcount() %></td></tr>    
<tr><td>제목</td>
    <td colspan="3"><%=bb.getSubject() %></td></tr>
<tr><td>파일</td>
    <td colspan="3"><a href="../upload/<%=bb.getFile()%>" download><%=bb.getFile() %></a></td></tr>    
<tr><td>내용</td>
    <td colspan="3"><%=bb.getContent() %></td></tr>
  	</table>
  	
  	<div id="table_search">
  	<%
  	// 세션값 가져오기
  	String id=(String)session.getAttribute("id");
  	// 로그인 (세션값이 있으면) 되어있으면
  	if(id != null){
// 로그인한 아이디(세션) , 글쓴 아이디 => 일치하면 글수정,글삭제 보임
		if(id.equals(bb.getName())){
  		%>
  	  	<input type="button" value="글수정" class="btn"
  		onclick="location.href='fupdate.jsp?num=<%=bb.getNum()%>'">
  		<input type="button" value="글삭제" class="btn"
  		onclick="location.href='fdelete.jsp?num=<%=bb.getNum()%>'">  		
  		<%
		}
  	}
  	%>
  		
  		<input type="button" value="글목록" class="btn"
  		onclick="location.href='fnotice.jsp'">
  	</div>
  	
  	<div class="clear"></div> 
  </article>
  
 <article>
    	<table id="notice">
  		<tr><th class="tno">No.</th>
  		    <th class="ttitle">Content</th>
  		    <th class="twrite">Write</th>
  		    <th class="tdate">Date</th>
  		    <th class="tread">Read</th></tr>
  		    <%
  		// 날짜를 년월일 뽑아서 문자열 변경
		   	SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
  		    for(int i=0;i<boardList.size();i++){
  		    	BoardBean bb2=boardList.get(i);
  		    	%>
   		<tr onclick="location.href='fcontent.jsp?num=<%=bb2.getNum()%>'"><td><%=bb2.getNum() %></td>
   		    <td class="left"><%=bb2.getContent() %></td>
   		    <td><%=bb2.getName() %></td>
  		    <td><%=sdf.format(bb2.getDate()) %></td>
  		    <td><%=bb2.getReadcount() %></td></tr> 		    	
  		    	<%
  		    }
  		    %>
     
  	</table>
</article>
  	
	
<div id="wrap">
	<br><br><br><br><br>
	<b><font size="5" color="gray">답글</font></b>
	<hr size="1" width="550">
	<br>

	<!-- 답글 등록 부분 시작-->
	<div id="writeReplyForm">
		<form name="replyInfo" target="replyForm">
			<!-- 부모 방명록의 정보를 같이 전송한다. -->
			<input type="hidden" name="guestbook_no" value="${guestbook.guestbook_no}"/>
			<input type="hidden" name="guestbook_group" value="${guestbook.guestbook_group}"/>
			
			<form action="guestinsert.jsp" method="post" >
			
				<tr>
					<td colspan="4">
						<td>&nbsp;&nbsp;&nbsp;</td><textarea rows="7" cols="70" name="guestbook_content"></textarea>
					</td>
				</tr>
			<input type="submit" value="등록" id="replyInsert" >
			</form>
			<br>
			<input type="button" value="창닫기" onclick="window.close()">
		</form>
	</div>
	<!-- 답글 등록 부분 끝-->
</div>
  
  
<div class="clear"></div>  
<!-- 푸터 들어가는곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는곳 -->
</div>
</body>
</html>


