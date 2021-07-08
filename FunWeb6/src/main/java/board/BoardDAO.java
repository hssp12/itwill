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

public class BoardDAO {

	// 1,2 단계 디비연결메서드
	private Connection getConnection() throws Exception {
		// JDBC프로그램 설치
		// 1,2 단계 context.xml 디비연결 => 자원이름을 불러와서 사용
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	// 리턴값 없음 insertBoard(BoardBean bb) 메서드 만들기
	public void insertBoard(BoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 1,2 디비연결
			con=getConnection();
			// 3 num구하는 sql
			String sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			// 4 실핼=> 결과저장
			rs=pstmt.executeQuery();
			// 5 결과를 접근해서 max(num)+1
			int num=0;
			if(rs.next()) {
				num=rs.getInt("max(num)")+1;
			}
			// 3 insert
			sql="insert into board(num,name,pass,subject,content,readcount,date) values(?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setTimestamp(7, bb.getDate());
			// 4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리 기억장소 해제
			if(rs!=null) try{rs.close();}catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException ex) {}
		}
	}

	//리턴할형 List<BoardBean> getBoardList(int startRow, int pageSize) 메서드 정의
	public List<BoardBean> getBoardList(int startRow, int pageSize){
		List<BoardBean> boardList=new ArrayList<BoardBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 1,2 디비연결
			con=getConnection();
			// 3 sql 
			String sql="select * from board order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
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
// 검색 메서드오버로딩 이용해서 메서드이름 동일 매개변수 개수 틀리게
	//리턴할형 List<BoardBean> getBoardList(int startRow, int pageSize, String search) 메서드 정의
	public List<BoardBean> getBoardList(int startRow, int pageSize,String search){
		List<BoardBean> boardList=new ArrayList<BoardBean>();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 1,2 디비연결
			con=getConnection();
			// 3 sql 
//			String sql="select * from board where subject like '%검색어%' order by num desc limit ?,?";
			String sql="select * from board where subject like     ?     order by num desc limit ?,?";
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
	
 // int count = getBoardCount() 메서드
	public int getBoardCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			//1,2 디비연결
			con=getConnection();
			// 3sql
			String sql="select count(*) from board";
			pstmt=con.prepareStatement(sql);
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
	
	 // int count = getBoardCount(search) 메서드
		public int getBoardCount(String search) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				//1,2 디비연결
				con=getConnection();
				// 3sql
				String sql="select count(*) from board where subject like ?";
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
		
//		bdao.updateReadcount(num);	
		public void updateReadcount(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				//1,2 디비연결
				con=getConnection();
				//3 sql update
				String sql="update board set readcount=readcount+1 where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				//4 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리 기억장소 해제
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
		
		// bdao.updateBoard(bb);
		public void updateBoard(BoardBean bb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				//1,2 디비연결
				con=getConnection();
				//3 sql update
				String sql="update board set subject=?,content=? where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, bb.getSubject());
				pstmt.setString(2, bb.getContent());
				pstmt.setInt(3, bb.getNum());
				//4 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리 기억장소 해제
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
		
		// bdao.deleteBoard(num);
		public void deleteBoard(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			try {
				//1,2 디비연결
				con=getConnection();
				//3 sql update
				String sql="delete from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				//4 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리 기억장소 해제
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
				if(con!=null) try{con.close();}catch(SQLException ex) {}
			}
		}
	
	
}// 클래스
