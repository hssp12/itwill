package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FileBoardDAO {
	// 디비연결 메서드
		private Connection getConnection() throws Exception{
//			 // 1단계 드라이버로더 
//			 Class.forName("com.mysql.jdbc.Driver");
//			 // 2단계 디비연결
//			 String dbUrl="jdbc:mysql://localhost:3306/jspdb3";
//			 String dbUser="root";
//			 String dbPass="1234";
//			 Connection con=DriverManager.getConnection(dbUrl,dbUser,dbPass);
//			 return con;
			 
			 // 톰캣에서 제공되는 CP(Connection Pool)를 위한
			 // DBCP(DataBase Connection Pool) API를 사용
			 
			 // CP(Connection Pool)
			 // 매번 드라이버 불러오고, 디비연결하는 작업을 하지않고
			 // 서버단에서 미리 디비연결을 하고 자원을 저장(Pool)해놓고
			 // 디비연결이 필요할때 자원이름을 불러서 사용
			 
			 // 1. META-INF 폴더 context.xml 만들기
			 //    드라이버 불러오고, 디비연결하는 작업=> 자원이름저장
			 // 2. DAO 파일에서 자원이름을 호출해서 사용
			
			Context init=new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
			Connection con=ds.getConnection();
			return con;
			 
		}
		
		// 리턴값 없음 finsertBoard(BoardBean bb) 메서드 만들기
		public void finsertBoard(BoardBean bb) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			try {
				// 1, 2 디비연결 메서드 호출
				con=getConnection();
				
				 // 글번호 구하기 
				 // => 게시판 글번호 중에 가장 큰 번호를 구해서 +1 
				 // => 이번에 입력할 글 번호 구하기
				 int num=0;
				 String sql2="select max(num) from fboard";
				 pstmt2=con.prepareStatement(sql2);
				 rs=pstmt2.executeQuery();
				 if(rs.next()){
				 	// num 최대값을 구해서 +1 => 이번에 입력할 글번호
				 	num=rs.getInt("max(num)")+1;
				 }
				 
				 // 3단계 sql insert 
				 // num , name, pass, subject, content, readcount, date
				 String sql="insert into fboard(num , name, pass, subject, content, readcount, date, file) values(?,?,?,?,?,?,?,?)";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, num);
				 pstmt.setString(2, bb.getName());
				 pstmt.setString(3, bb.getPass());
				 pstmt.setString(4, bb.getSubject());
				 pstmt.setString(5, bb.getContent());
				 pstmt.setInt(6, bb.getReadcount());
				 pstmt.setTimestamp(7, bb.getDate());
				 //file 추가
				 pstmt.setString(8, bb.getFile());
				 // 4단계 sql실행
				 pstmt.executeUpdate();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
				if(rs!=null) try{rs.close();}catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
		
		public List fgetBoardList(int startRow,int pageSize) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			// 배열안에 여러개 글주소 저장
			List boardList=new ArrayList();
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
				 // 3단계 sql select * from board order by num desc
				 //    최근글이 위에 보이기 위해서 num 내림차순으로 정렬해서 조회
//				 String sql="select * from board order by num desc";
//				 String sql="select * from board order by num desc limit 시작하는행-1,한화면에 보여줄 글개수";
				 String sql="select * from fboard order by num desc limit ?,?";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, startRow-1);
				 pstmt.setInt(2, pageSize);
				 // 4단계 실행 결과 저장
				 rs=pstmt.executeQuery();
				 // 5단계 while 결과 다음행 이동 => 열접근 
				 while(rs.next()) {
					 //게시판 글 하나의 바구니에 저장
					 BoardBean bb=new BoardBean();
					 bb.setNum(rs.getInt("num"));
					 bb.setName(rs.getString("name"));
					 bb.setPass(rs.getString("pass"));
					 bb.setSubject(rs.getString("subject"));
					 bb.setContent(rs.getString("content"));
					 bb.setReadcount(rs.getInt("readcount"));
					 bb.setDate(rs.getTimestamp("date"));
					 //file추가
					 bb.setFile(rs.getString("file"));
					 // 바구니의 주소값을 배열 한칸에  순서대로 저장 
					 boardList.add(bb);
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return boardList;
		}
		
		public List<BoardBean> fgetBoardList(int startRow, int pageSize,String search){
			List<BoardBean> boardList=new ArrayList<BoardBean>();
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				// 1,2 디비연결
				con=getConnection();
				// 3 sql 
//				String sql="select * from board where subject like '%검색어%' order by num desc limit ?,?";
				String sql="select * from fboard where subject like     ?     order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				// 4 실행=> 결과저장
				rs=pstmt.executeQuery();
				// 5 결과 => List<BoardBean> boardList 에 저장
				while(rs.next()) {
					// 다음행 이동 데이터 있으면 true 반복문 실행
					// 열접근 => BoardBean 저장
					BoardBean bb=new BoardBean();
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setPass(rs.getString("pass"));
					bb.setSubject(rs.getString("subject"));
					bb.setContent(rs.getString("content"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setDate(rs.getTimestamp("date"));
					// BoardBean => boardList 순서대로 배열한칸 저장
					boardList.add(bb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return boardList;
		}
		
		//int count=bdao.fgetBoardCount();
		public int fgetBoardCount() {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			int count=0;
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
				// 3sql 
				String sql="select count(*) from fboard";
				pstmt=con.prepareStatement(sql);
				// 4실행 => 결과저장
				rs=pstmt.executeQuery();
				// 5 결과 다음행으로 이동 열가져오기
				if(rs.next()) {
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
				if(rs!=null) try{rs.close();}catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return count;
		}
		
		public int fgetBoardCount(String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				//1,2 디비연결
				con=getConnection();
				// 3sql
				String sql="select count(*) from fboard where subject like ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				// 4 실행=> 결과저장
				rs=pstmt.executeQuery();
				// 5 결과 => 행접근 열접근 count(*) 조회 가져오기
				if(rs.next()) {
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return count;
		}
		
		// BoardBean bb  =  getBoard(num)
		public BoardBean getBoard(int num) {
			BoardBean bb=null;
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				//1,2 디비연결
				con=getConnection();
				//3 sql
				String sql="select * from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				//4 실행=> 결과저장
				rs=pstmt.executeQuery();
				// 5 결과 행접근 true=> 열접근 => BoardBean bb 저장
				if(rs.next()) {
					bb=new BoardBean();
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setPass(rs.getString("pass"));
					bb.setSubject(rs.getString("subject"));
					bb.setContent(rs.getString("content"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setDate(rs.getTimestamp("date"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리 기억장소 해제
				if(rs!=null) try{rs.close();}catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return bb;
		}
	
		// 메서드 정의  리턴할형 BoardBean   getBoard(int num)
		public BoardBean fgetBoard(int num) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			BoardBean bb=null;
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
				 // 3단계 sql 구문 조건 num=?
				 String sql="select * from fboard where num=?";
				pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, num);
				 // 4단계 실행 결과 저장
				 rs=pstmt.executeQuery();
				 // 5단계 if 다음행으로 이동 열접근 출력
				 if(rs.next()){
					 bb=new BoardBean();
					 bb.setNum(rs.getInt("num"));
					 bb.setName(rs.getString("name"));
					 bb.setPass(rs.getString("pass"));
					 bb.setSubject(rs.getString("subject"));
					 bb.setContent(rs.getString("content"));
					 bb.setReadcount(rs.getInt("readcount"));
					 bb.setDate(rs.getTimestamp("date"));
					 //file 추가
					 bb.setFile(rs.getString("file"));
				 }
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return bb;
		}
		
		// 조회수 증가 메서드 정의 리턴할형 없음 updateReadcount(int num)
		public void fupdateReadcount(int num) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
				 // readcount 조회수 1 증가 
				 // 3단계 sql
				 String sql="update fboard set readcount=readcount+1 where num=?";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, num);
				 // 4단계 실행
				 pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
		
		// 리턴할형 BoardBean  numCheck(int num,String pass) 메서드 정의
		public BoardBean fnumCheck(int num,String pass) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			BoardBean bb=null;
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
				 // 3단계 sql select 조건 num=? and pass=?
				 String sql="select * from fboard where num=? and pass=?";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, num);
				 pstmt.setString(2, pass);
				 // 4단계 실행 결과 저장
				 rs=pstmt.executeQuery();
				 // 5단계 rs 다음행 이동 데이터 있으면
				 if(rs.next()){
					 bb=new BoardBean();
					 bb.setNum(rs.getInt("num"));
					 bb.setName(rs.getString("name"));
					 bb.setPass(rs.getString("pass"));
					 bb.setSubject(rs.getString("subject"));
					 bb.setContent(rs.getString("content"));
					 bb.setReadcount(rs.getInt("readcount"));
					 bb.setDate(rs.getTimestamp("date"));
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return bb;
		}
		
//		bdao.updateBoard(bb2);
		public void fupdateBoard(BoardBean bb) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
			 	// 3단계 sql
			 	String sql2="update fboard set subject=?,content=?,file=? where num=?";
			 	pstmt2=con.prepareStatement(sql2);
			 	pstmt2.setString(1, bb.getSubject());
			 	pstmt2.setString(2, bb.getContent());
			 	// file
			 	pstmt2.setString(3, bb.getFile());
			 	pstmt2.setInt(4, bb.getNum());
			 	// 4단계 실행
			 	pstmt2.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
		
		// bdao.deleteBoard(num);
		public void fdeleteBoard(int num) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
			 	// 3단계 sql
			 	String sql2="delete from fboard where num=?";
			 	pstmt2=con.prepareStatement(sql2);
			 	pstmt2.setInt(1, num);
			 	// 4단계 실행
			 	pstmt2.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
		
		//--------------------------------------------------------댓글
		
		public List guestgetBoardList(int startRow,int pageSize) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			// 배열안에 여러개 글주소 저장
			List boardList=new ArrayList();
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
				 // 3단계 sql select * from board order by num desc
				 //    최근글이 위에 보이기 위해서 num 내림차순으로 정렬해서 조회
//				 String sql="select * from board order by num desc";
//				 String sql="select * from board order by num desc limit 시작하는행-1,한화면에 보여줄 글개수";
				 String sql="select * from guest order by num desc limit ?,?";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, startRow-1);
				 pstmt.setInt(2, pageSize);
				 // 4단계 실행 결과 저장
				 rs=pstmt.executeQuery();
				 // 5단계 while 결과 다음행 이동 => 열접근 
				 while(rs.next()) {
					 //게시판 글 하나의 바구니에 저장
					 BoardBean bb=new BoardBean();
					 bb.setNum(rs.getInt("num"));
					 bb.setName(rs.getString("name"));
					 bb.setPass(rs.getString("pass"));
					 bb.setSubject(rs.getString("subject"));
					 bb.setContent(rs.getString("content"));
					 bb.setReadcount(rs.getInt("readcount"));
					 bb.setDate(rs.getTimestamp("date"));
					 //file추가
					 bb.setFile(rs.getString("file"));
					 // 바구니의 주소값을 배열 한칸에  순서대로 저장 
					 boardList.add(bb);
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return boardList;
		}
		
		public BoardBean guestgetBoard(int num) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			BoardBean bb=null;
			try {
				// 1,2 디비연결 메서드 호출
				con=getConnection();
				 // 3단계 sql 구문 조건 num=?
				 String sql="select * from guest where num=?";
				pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, num);
				 // 4단계 실행 결과 저장
				 rs=pstmt.executeQuery();
				 // 5단계 if 다음행으로 이동 열접근 출력
				 if(rs.next()){
					 bb=new BoardBean();
					 bb.setNum(rs.getInt("num"));
					 bb.setName(rs.getString("name"));
					 bb.setPass(rs.getString("pass"));
					 bb.setSubject(rs.getString("subject"));
					 bb.setContent(rs.getString("content"));
					 bb.setReadcount(rs.getInt("readcount"));
					 bb.setDate(rs.getTimestamp("date"));
					 //file 추가
					 bb.setFile(rs.getString("file"));
				 }
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
							if(rs!=null) try{rs.close();}catch(SQLException ex) {}
							if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
							if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
							if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
			return bb;
		}
		
		
		public void guestinsertBoard(BoardBean bb) {
			Connection con=null;
			PreparedStatement pstmt2=null;
			ResultSet rs=null;
			PreparedStatement pstmt=null;
			try {
				// 1, 2 디비연결 메서드 호출
				con=getConnection();
				
				 // 글번호 구하기 
				 // => 게시판 글번호 중에 가장 큰 번호를 구해서 +1 
				 // => 이번에 입력할 글 번호 구하기
				 int num=0;
				 String sql2="select max(num) from fboard";
				 pstmt2=con.prepareStatement(sql2);
				 rs=pstmt2.executeQuery();
				 if(rs.next()){
				 	// num 최대값을 구해서 +1 => 이번에 입력할 글번호
				 	num=rs.getInt("max(num)")+1;
				 }
				 
				 // 3단계 sql insert 
				 // num , name, pass, subject, content, readcount, date
				 String sql="insert into guest(num , name, pass, subject, content, readcount, date, file) values(?,?,?,?,?,?,?,?)";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setInt(1, num);
				 pstmt.setString(2, bb.getName());
				 pstmt.setString(3, bb.getPass());
				 pstmt.setString(4, bb.getSubject());
				 pstmt.setString(5, bb.getContent());
				 pstmt.setInt(6, bb.getReadcount());
				 pstmt.setTimestamp(7, bb.getDate());
				 //file 추가
				 pstmt.setString(8, bb.getFile());
				 // 4단계 sql실행
				 pstmt.executeUpdate();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				// 예외상관없이 마무리(사용했던 내장객체 기억장소 해제)
				if(rs!=null) try{rs.close();}catch(SQLException ex) {}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
		
		
		
		
}//클래스
