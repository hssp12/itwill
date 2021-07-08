//package post;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//
//import com.mysql.jdbc.Util;
//
//public class PostDao {
// Connection conn = null;
// PreparedStatement pstmt = null;
// ResultSet rs = null;
// 
// public PostDao() throws SQLException{
//  conn = Util.getConnection();
// }
// 
// public ArrayList<PostVo> getAddrs(String search) throws SQLException{
//  ArrayList<PostVo> list = new ArrayList<PostVo>();
//  
//  StringBuffer sql = new StringBuffer();
//  sql.append("SELECT zip_code, addrs FROM post WHERE addrs like '%'|| :search ||'%' ");
// 
//  PreparedStatement pstmt = conn.prepareStatement(sql.toString());
//  pstmt.setString(1, search);
//  
//  ResultSet rs = pstmt.executeQuery();
//  while(rs.next()){
//   PostVo vo = new PostVo();
//   vo.setZip_code(rs.getInt("zip_code"));
//   vo.setAddrs(rs.getString("addrs"));
//   list.add(vo);
//  }
//  if(rs != null) rs.close();
//  if(pstmt != null) pstmt.close();
//  if(conn != null) conn.close();
//  
//  return list;
//  }
// }
