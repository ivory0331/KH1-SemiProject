package hyemin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;

import main.model.*;
import util.security.AES256;
import util.security.Sha256;

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

		
		// 페이징처리를 안 한, 특정 회원의 모든 작성가능 후기내역 보여주기
		@Override
		public List<OrderProductVO> selectPossibleReview(int member_num) throws SQLException {
			
			List<OrderProductVO> possibleReviewList= new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select OP.fk_order_num, P.representative_img, P.product_name, OP.product_count, P.product_num " + 
							 " from order_table O join order_product_table OP " + 
							 " on O.order_num = OP.fk_order_num " + 
							 " join product_table P " + 
							 " on OP.fk_product_num = P.product_num " + 
							 " where O.fk_member_num = ? and OP.reviewFlag = 0 and O.fk_category_num = 3 " + 
							 " order by fk_order_num desc ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, member_num);
				
				rs = pstmt.executeQuery();

				while(rs.next()) {
					
					int fk_order_num = rs.getInt(1);
					String representative_img = rs.getString(2);
					String product_name = rs.getString(3);
					int product_count = rs.getInt(4);
					int product_num = rs.getInt(5);
					
					ProductVO pvo = new ProductVO();			
					pvo.setProduct_name(product_name);
					pvo.setRepresentative_img(representative_img);
					pvo.setProduct_num(product_num);
					
					OrderProductVO opvo = new OrderProductVO();
					opvo.setOrder_num(fk_order_num);
					opvo.setCount(product_count);	
					opvo.setProduct(pvo);

					possibleReviewList.add(opvo);
				}	
				

			} catch( Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return possibleReviewList;
		}

		
		// 페이징처리를 안 한, 특정 회원의 모든 작성완료 후기내역 보여주기
		@Override
		public List<ReviewVO> selectCompleteReview(int member_num) throws SQLException {
			
			List<ReviewVO> completeReviewList= new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select R.review_num, P.product_name, to_char(R.write_date,'yyyy-mm-dd'), R.hit, R.favorite " + 
							 "	, R.subject, R.content " + 
							 " from product_table P join review_table R " + 
							 " on P.product_num = R.fk_product_num " + 
							 " where R.fk_member_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, member_num);
				
				rs = pstmt.executeQuery();

				while(rs.next()) {
					
					int review_num = rs.getInt(1);
					String product_name = rs.getString(2);
					String write_date = rs.getString(3);
					int hit = rs.getInt(4);
					int favorite = rs.getInt(5);
					String subject = rs.getString(6);
					String content = rs.getString(7);										
					
					ProductVO pvo = new ProductVO();
					pvo.setProduct_name(product_name);
					
					ReviewVO rvo = new ReviewVO();			
					rvo.setReview_num(review_num);
					rvo.setWrite_date(write_date);
					rvo.setHit(hit);
					rvo.setFavorite(favorite);
					rvo.setSubject(subject);
					rvo.setContent(content);
					rvo.setProduct(pvo);
														
					completeReviewList.add(rvo);
				}					

			} catch( Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return completeReviewList;
		}
		
		
		// 특정 회원의 작성가능 후기 내역 개수 알아보기
		@Override
		public int selectPossibleReviewCount(int member_num) throws SQLException {
			
			int pReviewCount = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) from( select OP.fk_order_num, P.representative_img, P.product_name, OP.product_count, P.product_num " + 
							 " from order_table O join order_product_table OP " + 
							 " on O.order_num = OP.fk_order_num " + 
							 " join product_table P " + 
							 " on OP.fk_product_num = P.product_num " + 
							 " where O.fk_member_num = ? and OP.reviewFlag = 0 and O.fk_category_num = 3 ) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, member_num);
				
				rs = pstmt.executeQuery();

				if(rs.next()) {
					pReviewCount = rs.getInt(1);
				}	
				

			} catch( Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return pReviewCount;
		}

		
		// 특정 회원의 작성완료 후기 내역 개수 알아보기
		@Override
		public int selectCompleteReviewCount(int member_num) throws SQLException {
			
			int cReviewCount = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) from( select R.review_num, P.product_name, R.write_date, R.hit, R.favorite " + 
							 "	, R.subject, R.content " + 
							 " from product_table P join review_table R " + 
							 " on P.product_num = R.fk_product_num " + 							 
							 " where R.fk_member_num = ? ) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, member_num);
				
				rs = pstmt.executeQuery();

				if(rs.next()) {
					cReviewCount = rs.getInt(1);
				}	
				

			} catch( Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return cReviewCount;
			
		}

		
		// 특정 작성완료 후기 삭제하기
		@Override
		public int deleteReview(String review_num) throws SQLException {
			
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " delete from review_table " + 
							 " where review_num = ? ";
						   
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, review_num);
				
				n = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return n;
			
		}

		
		// 후기 작성하기
		@Override
		public int writeReview(Map<String, String> paraMap) throws SQLException {
			int result = 0;
			String seq_num="";
			
			try {
				conn = ds.getConnection();
				conn.setAutoCommit(false);
				
				// 시퀀스 값 얻기
				String sql = " select last_number from user_sequences where SEQUENCE_NAME = 'SEQ_REVIEW_TABLE' ";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					seq_num = rs.getString(1);
					System.out.println("시퀀스 현재값 : "+seq_num);
				}
				rs.close();
				
				// 상품후기 insert
				sql = " insert into review_table(review_num, subject, content, fk_product_num, fk_order_num, fk_member_num) " + 
					  " values(seq_review_table.nextval, ?, ?, ?, ?, ?) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("subject"));
				pstmt.setString(2, paraMap.get("content"));
				pstmt.setString(3, paraMap.get("product_num"));
				pstmt.setString(4, paraMap.get("order_num"));
				pstmt.setString(5, paraMap.get("member_num"));
				
				result += pstmt.executeUpdate();
				
				if(result==0) {
					conn.rollback();
					return 0;
				}
				if(paraMap.get("image")!= null) {
					String fileNameArr = paraMap.get("image");
					sql = " insert into review_image_table (fk_review_num, image) "
					    + " values (?,?)";
					pstmt = conn.prepareStatement(sql);
					
						pstmt.setString(1, seq_num);
						pstmt.setString(2, fileNameArr);
						result+=pstmt.executeUpdate();
					
					if(result < 2) {
						conn.rollback();
						return 0;
					}
				}
				
				conn.commit();
				conn.setAutoCommit(true);
				
				sql = " update order_product_table set reviewFlag = 1 "
					+ " where fk_order_num = ? and fk_product_num = ? ";
								
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("order_num"));
				pstmt.setString(2, paraMap.get("product_num"));
				
				result = pstmt.executeUpdate();
								
			}
			finally {
				close();
			}

			return result;
		}


		
		
}




























