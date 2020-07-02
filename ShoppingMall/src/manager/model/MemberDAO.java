package manager.model;

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

import main.model.OrderHistoryVO;
import member.model.EncryptMyKey;
import member.model.MemberVO;
import util.security.AES256;

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

		
		
		//회원 상세 보기
		@Override
		public MemberVO detailMember(String member_num) throws SQLException {
			int n=0;
			
			MemberVO mvo = new MemberVO();
			
			try {		
				
				conn = ds.getConnection();		
				
				String sql = "select member_num, name, userid, email, mobile, "
						+ " postcode, address, detailaddress,gender,to_char(birthday,'yyyy-mm-dd') as birthday, "
						+ " to_char(registerdate,'yyyy-mm-dd') as registerdate "
						+ " from member_table " 
						+ " where member_num=? ";	
				
				pstmt = conn.prepareStatement(sql);		
				
				pstmt.setString(1, member_num);	
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					mvo.setMember_num(rs.getInt("member_num"));
					mvo.setName(rs.getString("name"));
					mvo.setUserid(rs.getString("userid"));
					mvo.setEmail(aes.decrypt(rs.getString("email")));
					mvo.setMobile(aes.decrypt(rs.getString("mobile")));
					mvo.setPostcode(rs.getString("postcode"));
					mvo.setAddress(rs.getString("address"));
					mvo.setDetailAddress(rs.getString("detailaddress"));
					mvo.setGender(rs.getString("gender"));
					mvo.setBirthday(rs.getString("birthday"));
					mvo.setRegisterdate(rs.getString("registerdate"));		
					
				}
				
				
				
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return mvo;
		}

		@Override
		public List<OrderHistoryVO> selectOneMemberAllOrder(String member_num) throws SQLException {
			 
		      List<OrderHistoryVO> orderHistoryList= new ArrayList<>();
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " select O.order_num " + 
		                   "      , to_char(O.order_date,'yyyy-mm-dd hh24:mi:ss') " + 
		                   "      , O.price " + 
		                   "      , OP.fk_product_num "+ 
		                   "      , P.product_name " + 
		                   "      , P.representative_img " + 
		                   "      , OS.order_state " + 
		                   " from order_table O " +
		                   " join order_product_table OP " +
		                   " on O.order_num = OP.fk_order_num " +
		                   " join order_state_table OS " + 
		                   " on O.fk_category_num = OS.category_num join product_table P " + 
		                   " on OP.fk_product_num = P.product_num " + 
		                   " where O.fk_member_num = ? " + 
		                   " order by O.order_num desc ";
		         
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, member_num);
		         
		         rs = pstmt.executeQuery();

		         while(rs.next()) {
		            
		            OrderHistoryVO ohvo = new OrderHistoryVO();
		            ohvo.setOrder_num(rs.getInt(1));
		            ohvo.setOrder_date(rs.getString(2));
		            ohvo.setPrice(rs.getInt(3));
		            ohvo.setFk_product_num(rs.getInt(4));
		            ohvo.setProduct_name(rs.getString(5));
		            ohvo.setRepresentative_img(rs.getString(6));
		            ohvo.setOrder_state(rs.getString(7));

		            orderHistoryList.add(ohvo);
		         }   
		         
		      rs.close();
		      
		      sql = " select count(*) from order_product_table where fk_order_num = ? ";
		      
		      pstmt = conn.prepareStatement(sql);
		      
		      for(int i=0; i<orderHistoryList.size(); i++) {      
		         
		         pstmt.setInt(1, orderHistoryList.get(i).getOrder_num());
		         
		         rs = pstmt.executeQuery();
		         
		         if(rs.next()) {
		            orderHistoryList.get(i).setProduct_cnt(rs.getInt(1));
		         }         
		      }

		      } catch( Exception e) {
		         e.printStackTrace();
		      } finally {
		         close();
		      }
		      
		      return orderHistoryList;

		}

	   
	   
		
}
