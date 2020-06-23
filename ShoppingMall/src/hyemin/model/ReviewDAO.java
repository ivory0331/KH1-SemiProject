package hyemin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;

import project.util.security.AES256;
import project.util.security.Sha256;

public class ReviewDAO implements InterReviewDAO {
	
	private DataSource ds;		// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes = null;
	
	// 생성자 
		public ReviewDAO() {
			// 암호화/복호화 키 (양방향암호화) ==> 이메일,휴대폰의 암호화/복호화
			String key = EncryptMyKey.KEY;
			
			try {
			    Context initContext = new InitialContext();
				Context envContext  = (Context)initContext.lookup("java:/comp/env");
				ds = (DataSource)envContext.lookup("jdbc/myoracle");
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

		
		// 상품 후기 작성하기
		@Override
		public int writeReview(ReviewVO reviewvo) throws SQLException {

			int result = 0;

		//	try {
				 conn = ds.getConnection();
				 
				 String sql = " insert into review_table(review_num, subject, content, write_date, image, fk_product_num, fk_order_num, fk_member_num) "+
						 	  " values(seq_review_table.nextval, ?, ?, default, ?, ?, ?, ?) ";
				 
				 pstmt = conn.prepareStatement(sql);
				 
				 pstmt.setString(1, reviewvo.getSubject());
				 pstmt.setString(2, reviewvo.getContent());
				 pstmt.setString(3, reviewvo.getImage());
				 
					
				 
				 
				 result = pstmt.executeUpdate();
		/*		 
			} catch( UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} finally {
				close();
			}
		*/	
			return result;
		}
		
		
}




























