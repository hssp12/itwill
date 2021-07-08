<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
  <div id="sub_img_center"></div>
  <!-- 왼쪽 메뉴 -->
  <nav id="sub_menu">
  	<ul>
  		<li><a href="../center/notice.jsp">Notice</a></li>
  		<li><a href="#">Public News</a></li>
  		<li><a href="../fcenter/fnotice.jsp">Driver Download</a></li>
  		<li><a href="#">Service Policy</a></li>
  	</ul>
  </nav>
  <!-- 본문 내용 -->
  <%
  // request한글처리
  request.setCharacterEncoding("utf-8");
  // 검색어 파라미터 가져오기 
  String search=request.getParameter("search");
//   System.out.println(search);
  //  http://localhost:8080/FunWeb/center/notice.jsp
  //  http://localhost:8080/FunWeb/center/notice.jsp?pageNum=2
  //  한화면에 보여줄 글개수 설정
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
//BoardDAO bdao 객체생성
FileBoardDAO bdao=new FileBoardDAO();
//리턴할형 List<BoardBean> getBoardList(int startRow, int pageSize) 메서드 정의
//List<BoardBean> boardList=getBoardList(startRow,pageSize,search)메서드호출

// 검색어 포함하는  getBoardList(startRow,pageSize,search) 
List<BoardBean> boardList=bdao.fgetBoardList(startRow, pageSize, search); 
  %>
  <article>
  	<h1>Notice Search</h1>
  	<table id="notice">
  		<tr><th class="tno">No.</th>
  		    <th class="ttitle">Title</th>
  		    <th class="twrite">Write</th>
  		    <th class="tdate">Date</th>
  		    <th class="tread">Read</th></tr>
  		    <%
  		// 날짜를 년월일 뽑아서 문자열 변경
		   	SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
  		    for(int i=0;i<boardList.size();i++){
  		    	BoardBean bb=boardList.get(i);
  		    	%>
   		<tr onclick="location.href='fcontent.jsp?num=<%=bb.getNum()%>'"><td><%=bb.getNum() %></td>
   		    <td class="left"><%=bb.getSubject() %></td>
   		    <td><%=bb.getName() %></td>
  		    <td><%=sdf.format(bb.getDate()) %></td>
  		    <td><%=bb.getReadcount() %></td></tr> 		    	
  		    	<%
  		    }
  		    %>
     
  	</table>
  	<div id="table_search">
  		<form action="fnoticeSearch.jsp" method="post">
  			<input type="text" name="search" class="input_box">
  			<input type="submit" value="search" class="btn">
  		</form>
  	</div>
  	<%
  	// String id = 세션값 가져오기
  	String id=(String)session.getAttribute("id");
  	// 세션값이 있으면( id null이 아니면) 글쓰기버튼 보이기  
  	if(id!=null){
  		%>
    <div id="table_search">
  		<input type="button" value="글쓰기" class="btn" 
  		onclick="location.href='fwrite.jsp'">
  	</div>
  		<%
  	}
  	%>

  	<div class="clear"></div> 
  	<div id="page_control">
<%
  	// 1~10 11~20 21~30
  	// 한화면에 보여줄 페이지 개수 설정
  	int pageBlock=10;
  	// 한화면에 시작하는 페이지번호 구하기
  	// currentPage   pageBlock => startPage
  	//  1~10(0~9)           10      => (1-1)/10*10+1=>1
  	//  11~20(10~19)        10      => (11-1)/10*10+1=>11
  	//  21~30(20~29)        10      => (21-1)/10*10+1=>21
  	int startPage=(currentPage-1)/pageBlock*pageBlock+1;
  	// 한화면에 끝나는 페이지 번호 구하기
  	// startPage pageBlock => endPage
  	//     1        10     => 10
  	//     11       10     => 20
  	int endPage=startPage+pageBlock-1;

  	// 전체글개수 구하기 
  	// select count(*) from board where subject like '%검색어%'
  	// int count = getBoardCount(search) 메서드 호출
  	// 검색어에 대한 글 개수 
  	int count=bdao.fgetBoardCount(search);
	
  	// 전체페이지개수 구하기  
  	// 전체글개수/한화면에보여줄글개수=> 페이지 5+0
  	// 전체글개수/한화면에보여줄글개수+(나머지글은 한페이지추가)=> 페이지 5+1
  	int pageCount=count/pageSize+(count%pageSize==0?0:1);
  	
  	
  	// 구한 endPage 보다 전체페이지 개수가 작으면
  	// endPage=전체페이지개수 변경
  	if(endPage > pageCount){
  		endPage = pageCount;
  	}
  	%>
  	<%
  	// Prev 이전에 10페이지 존재
  		if(startPage > pageBlock){
  			%><a href="fnoticeSearch.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search%>">Prev</a><%
  		}
  		%>
  		<%
  		for(int i=startPage;i<=endPage;i++){
%><a href="fnoticeSearch.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i %></a> <%
  		}
  		%>
  		<%
  		if(endPage < pageCount){
  			%><a href="fnoticeSearch.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">Next</a><%
  		}
  		%>
  	</div>
  </article>
  
  
<div class="clear"></div>  
<!-- 푸터 들어가는곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는곳 -->
</div>
</body>
</html>


