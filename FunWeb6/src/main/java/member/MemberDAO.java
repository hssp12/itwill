package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	// 1,2 단계 디비연결메서드
	private Connection getConnection() throws Exception {
		// JDBC프로그램 설치
		// 1,2 단계 context.xml 디비연결 => 자원이름을 불러와서 사용
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}

// 리턴값 없음 insertMember(MemberBean mb 바구니주소) 메서드정의
	public void insertMember(MemberBean mb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			// 1,2 단계 디비연결메서드 호출
			con=getConnection();
			// 3단계 sql 구문 만들기
			String sql="insert into member(id,pass,name,date,email,address,phone,mobile) values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getDate());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getAddress());
			pstmt.setString(7, mb.getPhone());
			pstmt.setString(8, mb.getMobile());
			// 4단계 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리 기억장소 해제
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException ex) {}
		}
	}
	
	// 리턴할형 MemberBean  userCheck(String id,String pass) 메서드정의
	public MemberBean userCheck(String id,String pass) {
		MemberBean mb=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 1,2 디비연결 메서드 호출
			con=getConnection();
			// 3 sql
			String sql="select * from member where id=? and pass=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			// 4 실행
			rs=pstmt.executeQuery();
			// 5 결과 첫번째 행 접근 => 열접근 
			// => 자바빈 객체생성 멤버변수저장
			if(rs.next()) {
				// 자바빈 객체생성
				mb=new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setDate(rs.getTimestamp("date"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리 기억장소 해제
			if(rs!=null) try{rs.close();}catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException ex) {}
		}
		return mb;
	}
	
	// 리턴할형 MemberBean  getMember(String id) 메서드 정의
	public MemberBean getMember(String id) {
		MemberBean mb=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			// 1,2 디비연결
			con=getConnection();
			// 3단계 sql 
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 실행 => 결과 저장
			rs=pstmt.executeQuery();
			// 5단계 결과 => 바구니에 저장 
			if(rs.next()) {
				// 바구니 객체 생성
				mb=new MemberBean();
				// set메서드 호출 rs열 데이터 저장
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setDate(rs.getTimestamp("date"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외 상관없이 마무리작업(기억장소 해제)
			if(rs!=null) try{rs.close();}catch(SQLException ex) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException ex) {}
		}
		return mb;
	}
	
//  리턴할형없음 updateMember(MemberBean mb2)메서드 정의
	public void updateMember(MemberBean mb2) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			// 1,2 디비연결
			con=getConnection();
			// 3 sql
			String sql="update member set name=?,email=?,address=?,phone=?,mobile=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb2.getName());
			pstmt.setString(2, mb2.getEmail());
			pstmt.setString(3, mb2.getAddress());
			pstmt.setString(4, mb2.getPhone());
			pstmt.setString(5, mb2.getMobile());
			pstmt.setString(6, mb2.getId());
			// 4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 예외 상관없이 마무리작업(기억장소 해제)
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException ex) {}
		}
	}
	
//	public void deleteMember(String id, String pass) {
//		Connection con=null;
//		PreparedStatement pstmt=null;
//		try {
//			// 1,2 단계 디비연결메서드 호출
//			con=getConnection();
//			// 3단계 sql 구문 만들기
//			String sql="delete from member where id = ? and pass = ?";
//			pstmt=con.prepareStatement(sql);
//			pstmt.setString(1, id);
//			pstmt.setString(2, pass);
//			
//			// 4단계 실행
//			pstmt.executeUpdate();
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}finally {
//			//마무리 기억장소 해제
//			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
//			if(con!=null) try{con.close();}catch(SQLException ex) {}
//		}
//	}
	
//	public void deleteMember(MemberBean mb2) {
//		Connection con=null;
//		PreparedStatement pstmt=null;
//		try {
//			// 1,2 디비연결
//			con=getConnection();
//			// 3 sql
//			String sql="delete from member where id = ? and pass = ?";
//			pstmt=con.prepareStatement(sql);
//			pstmt.setString(1, mb2.getId());
//			pstmt.setString(2, mb2.getPass());
//			
//			// 4 실행
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}finally {
//			// 예외 상관없이 마무리작업(기억장소 해제)
//			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
//			if(con!=null) try{con.close();}catch(SQLException ex) {}
//		}
//	}
	
	public void deleteMember(String id, String pass) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		try {
			// 1,2 디비연결 메서드 호출
			con=getConnection();
		 	// 3단계 sql
		 	String sql2="delete from member where id=?";
		 	pstmt2=con.prepareStatement(sql2);
		 	pstmt2.setString(1, id);
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
	
	
	
}//클래스





