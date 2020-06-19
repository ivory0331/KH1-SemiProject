package member.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {

	   private DataSource ds; 
	   private Connection conn;
	   private PreparedStatement pstmt;
	   private ResultSet rs;
	   
	   private AES256 aes = null;
	   
	   public MemberDAO() {
	      // 암호화/복호화 키 (양방향암호화) ==> 이메일,휴대폰의 암호화/복호화
	      String key = EncryptMyKey.KEY;
	      
	      try {
	          Context initContext = new InitialContext();
	         Context envContext  = (Context)initContext.lookup("java:/comp/env");
	         ds = (DataSource)envContext.lookup("jdbc/semiProject");
	         aes = new AES256(key);
	      } catch (NamingException e) {
	         e.printStackTrace();
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }   
	   }
	   
	   // 사용한 자원을 반납하는 close() 메소드 생성하기
	   public void close() {
	      try {
	         if(rs != null) { rs.close(); rs=null; }
	         if(pstmt != null) { pstmt.close(); pstmt=null; } 
	         if(conn != null) { conn.close(); conn=null; }
	      } catch (SQLException e) {
	         e.printStackTrace();
	      }
	   }
	   
	   
	   //ID중복 검사 (userid가 중복이 없어서 사용가능 true, 이미 존재하여 사용 불가능 false를 리턴)
	   @Override
		public boolean idDuplicateCheck(String userid) throws SQLException {
			
		   boolean isUse = false;
		   
		   try {
			   conn = ds.getConnection();
			   
			   String sql = " select userid " 
					   	  + " from member_table "
					   	  + " where userid = ? ";
					   	  
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setString(1, userid);
			  
			  rs = pstmt.executeQuery();			  
			  isUse = !rs.next(); //행이 존재하면 T이나 그것의 !반대니 F를 리턴 / isUse는 T일때 사용가능을 의미  				   	  
			
			} finally {
				close();
			}
		   
			return isUse;
	   }

	   // 이메일 중복 검사 메소드
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		 boolean isEmail = false;
		   
		   try {
			   conn = ds.getConnection();
			   
			   String sql = " select email " 
					   	  + " from member_table "
					   	  + " where email = ? ";
					   	  
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setString(1, Sha256.encrypt(email));
			  
			  rs = pstmt.executeQuery();			  
			  isEmail = !rs.next(); //행이 존재하면 T이나 그것의 !반대니 F를 리턴 / isUse는 T일때 사용가능을 의미  				   	  
			
			} finally {
				close();
			}
		   
			return isEmail;
	}

	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
}
