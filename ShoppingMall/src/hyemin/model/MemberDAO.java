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

	
	// 개인정보수정 전, 현재 비밀번호 확인하기
	@Override
	public int updatePwdCheck(String userid, String passwd) throws SQLException {
		
		int pwdCheck = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from member_table "
					   + " where userid = ? and pwd = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, Sha256.encrypt(passwd));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pwdCheck = rs.getInt(1);
			}

		} finally {
			close();
		}
		
		return pwdCheck;
	}
	
	
	// 특정 회원의 정보 수정하기
	@Override
	public int updateMember(MemberVO membervo) throws SQLException {
		
		int result = 0;

		try {
			 conn = ds.getConnection();
			 
			 String sql = " update member_table set userid=?, pwd_change_date=sysdate ";
			 
			 int cnt = 1;
			 if(membervo.getPwd() != "") {
				 sql += " , pwd='"+Sha256.encrypt(membervo.getPwd())+"' ";		// 암호를 SHA256 알고리즘으로 단방향암호화 시킨다. 
				 cnt++;
			 }
			 
			 if(membervo.getName() != "") {
				 sql += " , name='"+membervo.getName()+"' ";
				 cnt++;
			 }
			 
			 if(membervo.getEmail() != "") {
				 sql += " , email='"+aes.encrypt(membervo.getEmail())+"' ";		// 이메일을 AES256 알고리즘으로 양방향암호화 시킨다. 
				 cnt++;
			 }
			 
			 if(membervo.getMobile() != "") {
				 sql += " , mobile='"+aes.encrypt(membervo.getMobile())+"' ";	// 휴대폰번호를 AES256 알고리즘으로 양방향암호화 시킨다.
				 cnt++;
			 }
			 
			 if(membervo.getGender() != "") {
				 sql += " , gender='"+membervo.getGender()+"' ";
				 cnt++;
			 }
			 
			 if(membervo.getBirthday() != "") {
				 sql += " , birthday='"+membervo.getBirthday()+"' ";
				 cnt++;
			 }			 
			 
			 sql += " where member_num = '"+membervo.getMember_num()+"' ";
	
			 pstmt = conn.prepareStatement(sql);
				
			 pstmt.setString(1, membervo.getUserid());
							 
			 result = pstmt.executeUpdate();
			 
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}

		
}
