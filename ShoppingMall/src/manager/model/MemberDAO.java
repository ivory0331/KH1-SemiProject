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
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import main.model.OneInquiryVO;
import main.model.OrderHistoryVO;
import main.model.OrderProductVO;
import main.model.ProductVO;
import main.model.ReviewVO;
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
						+ " postcode, address, detailaddress,gender, birthday, "
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

		
		
		
		// 회원 주문 내역 조회
		@Override
		public List<OrderHistoryVO> orderCall(Map<String, Integer> paraMap) throws SQLException {
			
			 List<OrderHistoryVO> orderHistoryList= new ArrayList<>();
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql= " select RNO, order_num, order_date, price, order_state " + 
		                  "		, recipient, recipient_mobile, recipient_postcode, recipient_address, recipient_detailaddress " +
		                  " from " + 
		                  " (  " + 
		                  "    select rownum AS RNO, order_num, order_date, price, fk_category_num, order_state " + 
		                  "		, recipient, recipient_mobile, recipient_postcode, recipient_address, recipient_detailaddress " +
		                  "    from " + 
		                  "    (select order_num " + 
		                  "          , to_char(order_date,'yyyy.mm.dd') as order_date " + 
		                  "          , price, fk_category_num " +
		                  "			 , recipient, recipient_mobile, recipient_postcode, recipient_address, recipient_detailaddress "+
		                  "     from order_table " +
		                  "     where fk_member_num = ? " +
		                  "		order by order_num desc "+
		                  "    ) V " +
		                  " join order_state_table S " +
		                  " on V.fk_category_num = S.category_num "+
		                  " ) T " + 
		                  " where T.RNO between ? and ? ";
		         
		         pstmt = conn.prepareStatement(sql);
		         int currentShowPageNo = paraMap.get("currentPage");
		         int member_num = paraMap.get("member_num");
		         
		         pstmt.setInt(1, member_num);
		         pstmt.setInt(2,(currentShowPageNo * 5) - (5 - 1) );
		         pstmt.setInt(3, (currentShowPageNo * 5) ); // 공식
		         
		         rs = pstmt.executeQuery();

		         while(rs.next()) {
		            
		            OrderHistoryVO ohvo = new OrderHistoryVO();
		            ohvo.setOrder_num(rs.getInt("order_num"));
		            ohvo.setOrder_date(rs.getString("order_date"));
		            ohvo.setPrice(rs.getInt("price"));
		            ohvo.setOrder_state(rs.getString("order_state"));
		            ohvo.setRecipient(rs.getString("recipient"));
		            ohvo.setRecipient_mobile(rs.getString("recipient_mobile"));
		            ohvo.setRecipient_postcode(rs.getString("recipient_postcode"));
		            ohvo.setRecipient_address(rs.getString("recipient_address"));
		            ohvo.setRecipient_detailaddress(rs.getString("recipient_detailaddress"));
		            
		            orderHistoryList.add(ohvo);
		         }         
		         
		         rs.close();
		         
		         sql = " select P.product_name, P.representative_img, OP.product_count, OP.price "
		         		+ " from order_product_table OP "
		         		+ " join product_table P "
		         		+ " on OP.fk_product_num = P.product_num "
		         		+ "	where OP.fk_order_num = ? order by fk_order_num desc";
		         pstmt = conn.prepareStatement(sql);
		        

		 
		         for (int i = 0; i < orderHistoryList.size(); i++) {
		        	List<OrderProductVO> orderProductList = new ArrayList<>();	
		            pstmt.setInt(1, orderHistoryList.get(i).getOrder_num());
		            rs = pstmt.executeQuery();
		            int count = 0;
		            while (rs.next()) {
						OrderProductVO orderProduct = new OrderProductVO();
						ProductVO product = new ProductVO();
					    orderProduct.setCount(rs.getInt("product_count"));
						orderProduct.setPrice(rs.getInt("price"));
						product.setProduct_name(rs.getString("product_name"));
						product.setRepresentative_img(rs.getString("representative_img")); 
						orderProduct.setProduct(product);
						orderProductList.add(orderProduct);
						count++;
		            }
		            rs.close();
		            orderHistoryList.get(i).setProduct_cnt(count);
		            orderHistoryList.get(i).setOrderProductList(orderProductList);
		         }
		               
		      } catch( Exception e) {
		         e.printStackTrace();
		      } finally {
		         close();
		      }
		      return orderHistoryList;
		}

		
		
		
		// 회원 주문 페이징
		@Override
		public int getOrdertotalPage(Map<String, Integer> paraMap) throws SQLException {
			
			int result = 0;
			try {
				conn = ds.getConnection();
				String sql = " select ceil(count(*)/?) from order_table where fk_member_num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("pagePerNum"));
				pstmt.setInt(2, paraMap.get("member_num"));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}
			finally {
				close();
			}
			return result;
		}

		
		
		
		
		
		// 특정 회원 리뷰 조회
		@Override
		public List<ReviewVO> reviewCall(Map<String, Integer> paraMap) throws SQLException {
			List<ReviewVO> reviewList = new ArrayList<ReviewVO>();
			try {
				conn = ds.getConnection();
				String sql = " select RON, review_num, subject, content, write_date,"
						   + " fk_product_num, fk_order_num, fk_member_num, product_name "
						   + " from "
						   + " (select rownum as RON, review_num, subject, content, write_date, "
						   + " fk_product_num, fk_order_num, fk_member_num, product_name "
						   + " from "
						   + " 		(select R.review_num, R.subject, R.content, to_char(R.write_date,'yyyy-mm-dd') as write_date, "
						   + " 			R.fk_product_num, R.fk_order_num, R.fk_member_num, P.product_name "
						   + " 		from review_table R join product_table P "
						   + "		on P.product_num = R.fk_product_num "
						   + " 		where R.fk_member_num = ? order by review_num desc )V " 
						   + " )T where T.RON between ? and ? " ;
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("member_num"));
				pstmt.setInt(2, paraMap.get("start"));
				pstmt.setInt(3, paraMap.get("end"));
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReviewVO review = new ReviewVO();
					review.setReview_num(rs.getInt("review_num"));
					review.setSubject(rs.getString("subject"));
					review.setContent(rs.getString("content"));
					review.setWrite_date(rs.getString("write_date"));
					review.setFk_product_num(rs.getInt("fk_product_num"));
					review.setFk_order_num(rs.getInt("fk_order_num"));
					review.setFk_member_num(rs.getInt("fk_member_num"));
					review.setProduct_name(rs.getString("product_name"));
					reviewList.add(review);
				}
				rs.close();
				
				if(reviewList.size()>0) {
					sql = " select image from review_image_table where fk_review_num = ? ";
					pstmt = conn.prepareStatement(sql);
					for(int i=0; i<reviewList.size(); i++) {
						pstmt.setInt(1, reviewList.get(i).getReview_num());
						rs = pstmt.executeQuery();
						List<String>imageList = new ArrayList<String>();
						while(rs.next()) {
							String image = rs.getString(1);
							imageList.add(image);
						}
						rs.close();
						reviewList.get(i).setImageList(imageList);
					}
				}
			}
			finally {
				close();
			}
			
			return reviewList;		
			
		
		}

			
		
		// 리뷰 페이징
		@Override
		public int getReviewtotalPage(Map<String, Integer> paraMap) throws SQLException {
			
			int result = 0;
			try {
				conn = ds.getConnection();
				String sql = " select ceil(count(*)/?) from review_table where fk_member_num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("pagePerNum"));
				pstmt.setInt(2, paraMap.get("member_num"));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}
			finally {
				close();
			}
			return result;
			
		}

		
		
		// 일대일 질문 리스트 조회
		@Override
		public List<OneInquiryVO> oneQCall(Map<String, Integer> paraMap) throws SQLException {
			
			  List<OneInquiryVO> oneInquiryList = new ArrayList<OneInquiryVO>();
		      try {
		         conn = ds.getConnection();
		         String sql = " select RON, one_inquiry_num, subject, content, write_date, "
		                  + " answer, fk_member_num, fk_order_num, category_content "
		                  + " from"
		                  + " (select rownum as RON, one_inquiry_num, subject, content, "
		                  + " write_date, answer, fk_member_num, fk_order_num, category_content "
		                  + " from"
		                  + "    (select one_inquiry_num, subject, content, to_char(write_date,'yyyy-mm-dd') as write_date, answer, "
		                  + " 		fk_member_num, fk_order_num, fk_category_num, OC.category_content "
		                  + " 	  from one_inquiry_table O "
		                  + " 	  join one_category_table OC "
		                  + "	  on O.fk_category_num = OC.category_num "
		                  + "	  where O.fk_member_num = ? "
		                  + "	  order by one_inquiry_num desc )V"
		                  + " 	 )T "
		                  + " where T.RON between ? and ? ";
		         pstmt = conn.prepareStatement(sql);
		         
		         pstmt.setInt(1, paraMap.get("member_num"));
		         pstmt.setInt(2, paraMap.get("start"));
		         pstmt.setInt(3, paraMap.get("end"));
		         
		         rs = pstmt.executeQuery();
		         
		         while(rs.next()) {
		        	 OneInquiryVO inquiry = new OneInquiryVO();
		        	 inquiry.setOne_inquiry_num(rs.getInt("one_inquiry_num"));
		        	 inquiry.setSubject(rs.getString("subject"));
		        	 inquiry.setContent(rs.getString("content"));
		        	 inquiry.setWrite_date(rs.getString("write_date"));
		        	 inquiry.setAnswer(rs.getString("answer"));
		        	 if(rs.getString("answer")==null) {
		        		 inquiry.setAnswer_content("미답변");
		        	 }else {
		        		 inquiry.setAnswer_content("답변완료");
		        	 }
		        	 inquiry.setFk_member_num(rs.getInt("fk_member_num"));
		        	 inquiry.setFk_order_num(rs.getInt("fk_order_num"));
		        	 inquiry.setCategory_content(rs.getString("category_content"));
					 oneInquiryList.add(inquiry);
				}		         
		         
		      } finally {
		          close();
		          
		          
		      }
		      
		      return oneInquiryList;
	
		}
		
		
		
		// 일대일 질문 페이징
		@Override
		public int getOneQtotalPage(Map<String, Integer> paraMap) throws SQLException {
			
			int result = 0;
			try {
				conn = ds.getConnection();
				String sql = " select ceil(count(*)/?) from one_inquiry_table where fk_member_num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("pagePerNum"));
				pstmt.setInt(2, paraMap.get("member_num"));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			}
			finally {
				close();
			}
			return result;
		}

		
		
	   
	   
		
}
