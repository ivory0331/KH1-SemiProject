package hyemin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;

import member.model.MemberVO;
import util.security.AES256;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {
	
	private DataSource ds;		// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes = null;
	
	// 생성자 
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

	
	// 특정 회원의 정보 수정하기
	@Override
	public int updateMember(MemberVO membervo) throws SQLException {
		
		int result = 0;

		try {
			 conn = ds.getConnection();
			 
			 String sql = " update member_table set userid=?, pwd=?, name=?, email=?, mobile=?, gender=?, birthday=?, pwd_change_date=sysdate "       
				        + " where member_num = ? ";
			 
			 pstmt = conn.prepareStatement(sql);
				
			 pstmt.setString(1, membervo.getUserid());
			 pstmt.setString(2, Sha256.encrypt(membervo.getPwd()) ); // 암호를 SHA256 알고리즘으로 단방향암호화 시킨다. 
			 pstmt.setString(3, membervo.getName());  
			 pstmt.setString(4, aes.encrypt(membervo.getEmail()) );  // 이메일을 AES256 알고리즘으로 양방향암호화 시킨다. 
			 pstmt.setString(5, aes.encrypt(membervo.getMobile()));  // 휴대폰번호를 AES256 알고리즘으로 양방향암호화 시킨다.
			 pstmt.setString(6, membervo.getGender());
			 pstmt.setString(7, membervo.getBirthday());
			 pstmt.setInt(8, membervo.getMember_num());
							 
			 result = pstmt.executeUpdate();
			 
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}
		
	
		
}
