package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.Sha256;


/**
 * @author Eunhye
 */
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
         Context envContext = (Context) initContext.lookup("java:/comp/env");
         ds = (DataSource) envContext.lookup("jdbc/semiProject");
         aes = new AES256(key);
      } catch (NamingException e) {
         e.printStackTrace();
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
   }

   // 사용한 자원을 반납하는 close() 생성
   public void close() {
      try {
         if (rs != null) {
            rs.close();
            rs = null;
         }
         if (pstmt != null) {
            pstmt.close();
            pstmt = null;
         }
         if (conn != null) {
            conn.close();
            conn = null;
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }
   }

   // ID중복 검사 (userid가 중복이 없어서 사용가능 true, 이미 존재하여 사용 불가능 false를 리턴)
   @Override
   public boolean idDuplicateCheck(String userid) throws SQLException {

      boolean isUse = false;

      try {
         conn = ds.getConnection();

         String sql = " select userid " + " from member_table " + " where userid = ? ";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, userid);

         rs = pstmt.executeQuery();
         isUse = !rs.next(); // 행이 존재하면 F를 리턴 / isUse는 T일때 사용가능을 의미

      } finally {
         close();
      }
      return isUse;
   }

   // 이메일 중복 검사
   @Override
   public boolean emailDuplicateCheck(String email) throws SQLException {
      boolean isEmail = false;

      try {
         conn = ds.getConnection();
         String sql = " select email " + " from member_table " + " where email = ? ";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, Sha256.encrypt(email));

         rs = pstmt.executeQuery();
         isEmail = !rs.next(); // 행이 존재하면 F를 리턴

      } finally {
         close();
      }
      return isEmail;
   }

   // 회원가입 메소드
   @Override
   public int registerMember(MemberVO membervo) throws SQLException {
      int result = 0;

      try {

         conn = ds.getConnection();

         String sql = " insert into member_table(member_num, name, userid, pwd, email, mobile, postcode, address, detailAddress, gender, birthday) "
                  + " values(seq_member_table.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

         pstmt = conn.prepareStatement(sql);

         pstmt.setString(1, membervo.getName());
         pstmt.setString(2, membervo.getUserid());
         pstmt.setString(3, Sha256.encrypt(membervo.getPwd())); // 암호를 SHA256 알고리즘으로 단방향암호화 시킨다.
         pstmt.setString(4, aes.encrypt(membervo.getEmail()));  // 이메일을 AES256 알고리즘으로 양방향암호화 시킨다.
         pstmt.setString(5, aes.encrypt(membervo.getMobile()));    // 휴대폰번호를 AES256 알고리즘으로 양방향암호화 시킨다.
         pstmt.setString(6, membervo.getPostcode());
         pstmt.setString(7, membervo.getAddress());
         pstmt.setString(8, membervo.getDetailAddress());
         pstmt.setString(9, membervo.getGender());
         pstmt.setString(10, membervo.getBirthday());

         result = pstmt.executeUpdate();

      } catch (UnsupportedEncodingException | GeneralSecurityException e) {
         e.printStackTrace();

      } finally {
         close();
      }
      return result;
   }

   //로그인(아이디와 암호를 입력받아서 회원 정보 리턴)
   @Override
   public MemberVO selectOneMember(HashMap<String, String> paraMap) throws SQLException {
      MemberVO mvo = null;
      
      try {
         conn = ds.getConnection();
         
         String sql = " select member_num, userid, name, email, mobile, postcode, address, detailaddress, gender, birthday, status, to_char(registerdate,'yyyy-mm-dd') as registerdate " + 
                  "     , trunc( months_between(sysdate, pwd_change_date) ) AS pwd_change_date " + 
                  "     , trunc( months_between(sysdate, last_login_date) ) AS last_login_date " + 
                  " from member_table " + 
                  " where status in (1,2) and userid = ? and pwd = ? ";
                       
          pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, paraMap.get("userid")); //loginAction에서 준 키값 
         pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd") )); //암호화되어진 것으로 
         
          rs = pstmt.executeQuery();
          
          if(rs.next()) {
             mvo = new MemberVO();
             mvo.setMember_num(rs.getInt("member_num"));
             mvo.setUserid(rs.getString("userid"));
             mvo.setName(rs.getString("name"));
             mvo.setEmail(aes.decrypt(rs.getString("email"))); //양방향 복호화
             mvo.setMobile( aes.decrypt(rs.getString("mobile")));//양방향 복호화
             mvo.setPostcode(rs.getString("postcode"));
             mvo.setAddress(rs.getString("address"));
             mvo.setDetailAddress(rs.getString("detailaddress"));
             mvo.setGender(rs.getString("gender"));
             mvo.setBirthday(rs.getString("birthday"));
             mvo.setRegisterdate(rs.getString("registerdate"));
             mvo.setStatus(rs.getInt("status"));
             
             //마지막 암호변경 날짜 현재시각으로 3개월 지났으면 true, 안지났음 false로 표식
             if(rs.getInt("pwd_change_date") >= 3){
                //로그인시 암호를 변경해라는 alert를 띄우도록 한다. 
                mvo.setRequirePwdChange(true); //로그인시 암호 변경 alert을 띄우도록 한다 
             }
             
             //마지막으로 로그인 한 날짜가 현재일로부터 1년(==12개월)이 지났으면 휴먼처리 
             if(rs.getInt("last_login_date") >= 12 ) {
                //MemberVO에 휴먼계정관한 처리 가져옴
                mvo.setIdleStatus(true); //계정을 휴먼처리함.                
             }
             else {

                //마지막으로 로그인 한 날짜시간 기록하기
                sql = "update member_table set last_login_date = sysdate "
                   + "where userid = ? ";
                pstmt = conn.prepareStatement(sql);
                
                pstmt.setString(1, paraMap.get("userid"));
                pstmt.executeUpdate();                
             }             
          }
         
      }catch(UnsupportedEncodingException | GeneralSecurityException e) {
         e.printStackTrace();
         
      }finally {
         close();
      }      
      return mvo;
   }

   
   // == 휴면상태 사용자계정 로그인 시 휴면해제(lastLoginDate 컬럼 값 sysdate로 update)
   @Override
   public void expireIdle(int member_num) throws SQLException {
      
      try {
         conn = ds.getConnection();
         String sql = " update member_table set last_login_date = sysdate "
                  + " where member_num = ? " ;
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, member_num);
         
         pstmt.executeUpdate();
         
      }finally {
         close();
      }
   }

   //아이디 찾기(성명, 이메일을 입력받아 아이디찾기)
   @Override
   public String findUserid(HashMap<String, String> paraMap) throws SQLException {
         
      String userid = null; 
      
      try {
         conn = ds.getConnection();
         
         String sql = " select userid "
                      + " from member_table "
                      + " where status = 1 and name = ? and email = ? ";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, paraMap.get("name"));
         pstmt.setString(2, aes.encrypt(paraMap.get("email")));
         
         rs = pstmt.executeQuery();
         
         if(rs.next()){ //만약 행이 있다면, null이 아닌 것을 체크해서 넘김 
            userid = rs.getString("userid");            
         }
         
      } catch (UnsupportedEncodingException | GeneralSecurityException e) {
         
         e.printStackTrace();
      } finally {
         close();
      }
      
      return userid;
      
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   ////////////////////////////////// 매니저 진하
// 전체 회원 보기
	@Override
	public List<MemberVO> selectAllMember() throws SQLException {
		
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		
		
		try {			
			conn = ds.getConnection();
			
			String sql = " select member_num, name, userid, address" 					
						+" from member_table "
						+" order by member_num desc ";
			//여기 나중에 status 추가해서 관리가 빼야 됨.
			//전화번호 컬럼 추가
			
			pstmt = conn.prepareStatement(sql);			
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO mvo = new MemberVO();
				mvo.setMember_num(rs.getInt("member_num"));
				mvo.setName(rs.getString("name"));
				mvo.setUserid(rs.getString("userid"));
				mvo.setAddress(rs.getString("address"));
	            
	            memberList.add(mvo);
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close();
		}
							
		return memberList;
	}

	
	
	// 검색어 처리
	@Override
	public List<MemberVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException {
		
		List<MemberVO> memberList = new ArrayList<MemberVO>();		
		
		try {			
			conn = ds.getConnection();
			
			String sql = " select RNO, member_num, name, userid, address "
						+" from "
						+" ( select rownum AS RNO, member_num, name, userid, address "
						+"   from "
						+"     ( select member_num, name, userid, address "
						+"       from member_table ";
						
			String searchWord = paraMap.get("searchWord");
			String searchType = paraMap.get("searchType");
				
			if(searchWord != null && !searchWord.trim().isEmpty()) {      
		            
		            sql += " where "+searchType+" like '%'||?||'%' ";                  
		    }
		         
		    sql +=    "       order by member_num desc "
		           +"     )V "
		           +" )T "
		           +" where T.RNO between ? and ? ";     				
			
			pstmt = conn.prepareStatement(sql);			
		
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));

			// 공식
			if(searchWord != null && !searchWord.trim().isEmpty()) {	

				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo*sizePerPage)-sizePerPage+1);
				pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
				
			}else {
				
				pstmt.setInt(1, (currentShowPageNo*sizePerPage)-sizePerPage+1);
				pstmt.setInt(2, (currentShowPageNo*sizePerPage) );
			}
		
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO mvo = new MemberVO();
				mvo.setMember_num(rs.getInt("member_num"));
				mvo.setName(rs.getString("name"));
				mvo.setUserid(rs.getString("userid"));
				mvo.setAddress(rs.getString("address"));
	            
	            memberList.add(mvo);
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			close();
		}
			
				
		return memberList;
	
	}

	
	// 페이징 그룹
	@Override
	public int getTotalPage(HashMap<String, String> paraMap) throws SQLException {
	
		int totalPage = 0;
		
		try {
			conn=ds.getConnection();
			
			String sql = " select ceil(count(*)/?) as totalPage "
						+" from member_table ";
			
			String searchWord = paraMap.get("searchWord");
			String searchType = paraMap.get("searchType");
			
			if(searchWord !=null && !searchWord.trim().isEmpty()) {		
				
				sql += " where "+searchType+" like '%'||?||'%' ";						
			}
			
			
			pstmt = conn.prepareStatement(sql);
			
			
			if(searchWord !=null && !searchWord.trim().isEmpty()) {		
				
				pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
				pstmt.setString(2, searchWord);
								
			}else {
				pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
			}
			
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
			System.out.println("totalPage : "+totalPage);
			
		}catch(Exception e){
			e.printStackTrace();
		} finally {
			close();
		}
		
		return totalPage;

	}

	
	
	//회원 삭제
	@Override
	public int memberDelete(String member_num) throws SQLException {
		
		int result = 0;
		
		try {		
			
			conn = ds.getConnection();			
			String sql = "delete from member_table where member_num= ?";			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, member_num);			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
			
		
		return result;		
		}

   
   
   
   
   
   
   
   
   
   
   
   
   
}