package main.model;

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

import member.model.EncryptMyKey;
import member.model.MemberVO;
import util.security.AES256;
import product.model.*;

public class IndexDAO implements InterIndexDAO{

	private DataSource ds; 
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes = null;
	
	// 생성자 
	public IndexDAO() {
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
	
	
	// index.jsp에서 보는 DIV에 나타낼 리스트 출력
	@Override
	public List<ProductVO> listCall(Map<String,String>paraMap) throws SQLException {
		List<ProductVO> productList = new ArrayList<ProductVO>();
		String type = paraMap.get("type");
		try {
			conn = ds.getConnection();
			String sql = "";
			String subSql = " select product_num, product_name, price, stock, sale, to_char(registerdate,'yyyy-mm-dd') as registerdate, representative_img from product_table ";
			
			switch (type) {
			case "sale":
				subSql+=" order by sale desc ";
				break;
			case "best" :
				subSql+=" where fk_category_num = ? order by best_point desc ";
				break;
			case "new":
				subSql+=" order by registerdate desc ";
				break;
			default:
				break;
			}
			
			if("random".equals(type)) {
				sql= subSql+" where product_num in(?,?,?,?,?,?,?,?) ";
			}
			else {
				sql=" select ROM,product_num, product_name, price, stock, sale, representative_img from (select rownum as ROM, product_num, product_name, price, stock, sale, representative_img  from("+subSql+") )T where T.ROM between 1 and 8 ";

			}
			
			pstmt = conn.prepareStatement(sql);
			
			if("best".equals(type)) pstmt.setString(1, paraMap.get("category"));
			
			else if("random".equals(type)) {
				String num = paraMap.get("random");
				String[] numArr = num.split(",");
				for(int i=0; i<numArr.length; i++) {
					pstmt.setString(i+1, numArr[i]);
				}
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO product = new ProductVO();
				product.setProduct_num(rs.getInt("product_num"));
				product.setSale(rs.getInt("sale"));
				product.setProduct_name(rs.getString("product_name"));
				product.setPrice(rs.getInt("price"));
				product.setStock(rs.getInt("stock"));
				product.setRepresentative_img(rs.getString("representative_img"));
				product.setFinalPrice();
				productList.add(product);
			}
			
		
		}
		finally {
			close();
		}
		
		
		return productList;
	}

	// 상세페이지에 나타낼 ProductVO 조회
	@Override
	public ProductVO productDetail(String idx) throws SQLException {
		ProductVO product = null;
		
		try {
			conn = ds.getConnection();
			String sql = " select P.product_num, P.product_name, P.price, P.sale, P.stock, P.origin, P.packing, P.unit, P.representative_img, P.explain, C.category_content , S.subcategory_content" + 

					" from product_table P join product_category_table C \r\n" + 
					" on P.fk_category_num = C.category_num  " + 
					" join product_subcategory_table S\r\n" + 
					" on P.fk_subcategory_num = S.subcategory_num " + 
					" where P.product_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println("DB조회 성공");
				product = new ProductVO();
				product.setProduct_num(rs.getInt(1));
				product.setProduct_name(rs.getString(2));
				product.setPrice(rs.getInt(3));
				product.setSale(rs.getInt(4));
				product.setStock(rs.getInt(5));
				product.setOrigin(rs.getString(6));
				product.setPacking(rs.getString(7));
				product.setUnit(rs.getString(8));

				product.setRepresentative_img(rs.getString(9));
				product.setExplain(rs.getString(10));
				product.setCategory_content(rs.getString(11));
				product.setSubcategory_content(rs.getString(12));
				
				product.setFinalPrice();
			}
		}
		finally {
			close();
		}
		return product;
	}

	// 모든 상품번호 조회 //
	@Override
	public List<String> product_numFind() throws SQLException {
		List<String> product_numArr = new ArrayList<String>();
		try {
			conn = ds.getConnection();
			String sql = " select product_num from product_table where stock > 0 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String product_num = rs.getString(1);
				product_numArr.add(product_num);
			}
		}
		finally {
			close();
		}
		return product_numArr;
	}

	// 특정 상품 후기 조회 //
	@Override
	public List<ReviewVO> reviewCall(String product_num) throws SQLException {
		List<ReviewVO> reviewList = new ArrayList<ReviewVO>();
		try {
			conn = ds.getConnection();
			String sql = " select R.review_num, R.subject, R.content, to_char(R.write_date,'yyyy-mm-dd') as write_date,"
					   + " R.hit, R.favorite, R.fk_product_num, R.fk_order_num, R.fk_member_num, M.name"
					   + " from review_table R join member_table M on R.fk_member_num = M.member_num where R.fk_product_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_num);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewVO review = new ReviewVO();
				review.setReview_num(rs.getInt(1));
				review.setSubject(rs.getString(2));
				review.setContent(rs.getString(3));
				review.setWrite_date(rs.getString(4));
				review.setHit(rs.getInt(5));
				review.setFavorite(rs.getInt(6));
				review.setFk_product_num(rs.getInt(7));
				review.setFk_order_num(rs.getInt(8));
				review.setFk_member_num(rs.getInt(9));
				review.setName(rs.getString(10));
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

	
	// 특정 상품의 상품문의 조회 //
	@Override
	public List<ProductInquiryVO> productQCall(Map<String, Integer> paraMap) throws SQLException {
		List<ProductInquiryVO> productQList = new ArrayList<ProductInquiryVO>();
		
		
		try {
			conn = ds.getConnection();
			String sql = " select T.RON, inquiry_num, subject, content, write_date, answer, emailFlag, smsFlag, secretFlag, fk_member_num, name"
					   + " from (select rownum as RON, PI.inquiry_num, PI.subject, PI.content, to_char(PI.write_date,'yyyy-mm-dd') as write_date,"
					   + " PI.answer, PI.emailFlag, PI.smsFlag, PI.secretFlag, PI.fk_member_num, M.name "
					   + " from product_inquiry_table PI join member_table M "
					   + " on PI.fk_member_num = M.member_num "
					   + " where PI.fk_product_num = ?)T where T.RON between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paraMap.get("product_num"));
			pstmt.setInt(2, paraMap.get("start"));
			pstmt.setInt(3, paraMap.get("end"));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductInquiryVO productQ = new ProductInquiryVO();
				productQ.setInquiry_num(rs.getInt(2));
				productQ.setSubject(rs.getString(3));
				productQ.setContent(rs.getString(4));
				productQ.setWrite_date(rs.getString(5));
				productQ.setAnswer(rs.getString(6));
				productQ.setEmailFlag(rs.getInt(7));
				productQ.setSmsFlag(rs.getInt(8));
				productQ.setSecretFlag(rs.getInt(9));
				productQ.setFk_member_num(rs.getInt(10));
				productQ.setName(rs.getString(11));
				productQList.add(productQ);
			}
			rs.close();
			
			if(productQList.size()>0) {
				sql = " select image from product_inquiry_image_table where fk_inquiry_num = ? ";
				pstmt = conn.prepareStatement(sql);
				for(int i=0; i<productQList.size(); i++) {
					pstmt.setInt(1, productQList.get(i).getInquiry_num());
					rs = pstmt.executeQuery();
					List<String>imageList = new ArrayList<String>();
					while(rs.next()) {
						String image = rs.getString(1);
						imageList.add(image);
					}
					rs.close();
					productQList.get(i).setImageList(imageList);
				}
			}
		}
		finally {
			close();
		}
		
		return productQList;
	}

	// 카테고리 정보 조회
	@Override
	public List<Map<String, String>> categoryCall() throws SQLException {
		List<Map<String, String>> categoryList = new ArrayList<Map<String,String>>();
		try {
			conn = ds.getConnection();
			String sql = " select * from product_category_table union select * from product_subcategory_table ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Map<String, String> category = new HashMap<String, String>();
				category.put("num", rs.getString(1));
				category.put("content", rs.getString(2));
				categoryList.add(category);
			}
		}
		finally {
			close();
		}
		return categoryList;
	}

	// 장바구니 조회
	@Override
	public boolean basketSelect(Map<String, String> orderMap) throws SQLException {
		boolean check = false;
		String product_num = orderMap.get("product_num");
		String member_num = orderMap.get("member_num");
		try {
			conn = ds.getConnection();
			String sql = " select * from basket_table where fk_member_num = ? and fk_product_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_num);
			pstmt.setString(2, product_num);
			
			rs = pstmt.executeQuery();
			check = !rs.next();
		}
		finally {
			close();
		}
		return check;
	}

	// 선택한 상품 장바구니에 추가
	@Override
	public int basketInsert(Map<String, String> orderMap) throws SQLException {
		int result = 0;
		String product_num = orderMap.get("product_num");
		String member_num = orderMap.get("member_num");
		String count = orderMap.get("count");
		String price = orderMap.get("price");
		
		
		try {
			conn = ds.getConnection();
			String sql = " insert into basket_table(basket_num, product_count, fk_member_num, fk_product_num)"
					   + " values(seq_basket_table.nextval, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, count);
			pstmt.setString(2, member_num);
			pstmt.setString(3, product_num);
			
			result = pstmt.executeUpdate();
			
		}
		finally {
			close();
		}
		return result;
	}

	// 장바구니 상품 수 조회
	@Override
	public int basketCnt(int member_num) throws SQLException {
		int count = 0;
		try {
			conn = ds.getConnection();
			String sql = " select count(*) from basket_table where fk_member_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		}
		finally {
			close();
		}
		
		return count;
	}

	// 상품문의 글 작성
	@Override
	public int productQwrite(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		String seq_num="";
		
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			
			// 시퀀스 값 얻기
			String sql = " select last_number from user_sequences where SEQUENCE_NAME = 'SEQ_PRODUCT_INQUIRY' ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				seq_num = rs.getString(1);
				System.out.println("시퀀스 현재값 : "+seq_num);
			}
			rs.close();
			
			// 상품문의 테이블 정보 insert
			sql = " insert into product_inquiry_table (inquiry_num, subject, content, fk_member_num, fk_product_num, emailFlag, smsFlag, secretFlag) "
			    + " values(seq_product_inquiry.nextval, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("subject"));
			pstmt.setString(2, paraMap.get("content"));
			pstmt.setString(3, paraMap.get("member_num"));
			pstmt.setString(4, paraMap.get("product_num"));
			pstmt.setString(5, paraMap.get("emailFlag"));
			pstmt.setString(6, paraMap.get("smsFlag"));
			pstmt.setString(7, paraMap.get("secretFlag"));
			
			result += pstmt.executeUpdate();
			
			if(result==0) {
				conn.rollback();
				return 0;
			}
			if(paraMap.get("fileName")!= null) {
				String[] fileNameArr = paraMap.get("fileName").split(",");
				sql = " insert into product_inquiry_image_table (fk_inquiry_num, image) "
				    + " values (?,?)";
				pstmt = conn.prepareStatement(sql);
				for(int i=0; i<fileNameArr.length; i++) {
					pstmt.setString(1, seq_num);
					pstmt.setString(2, fileNameArr[i]);
					result+=pstmt.executeUpdate();
				}
				if(result < (fileNameArr.length+1)) {
					conn.rollback();
					return 0;
				}
			}
			
			conn.commit();
			
			
		}
		finally {
			close();
		}
		
		
		return result;
	}

	// 상품문의 삭제
	@Override
	public int inquiryDel(String inquiry_num) throws SQLException {
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = " delete from product_inquiry_table where inquiry_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,inquiry_num);
			result = pstmt.executeUpdate();
		}
		finally {
			close();
		}
		
		return result;
	}

	// 특정 상품문의 글 조회
	@Override
	public ProductInquiryVO inquiryOneSelect(String inquiry_num) throws SQLException {
		ProductInquiryVO pivo = null;
		List<String> imageList = new ArrayList<String>();
		try {
				conn = ds.getConnection();
				String sql = " select PI.inquiry_num, PI.subject, PI.content, to_char(PI.write_date,'yyyy-mm-dd') as write_date,"
						   + " PI.fk_member_num, PI.fk_product_num, PI.emailFlag, PI.smsFlag, PI.secretFlag,"
						   + " M.name, M.userid, M.email, M.mobile "
						   + " from product_inquiry_table PI join member_table M on PI.fk_member_num = M.member_num where PI.inquiry_num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, inquiry_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					pivo = new ProductInquiryVO();
					MemberVO mvo = new MemberVO();
					pivo.setInquiry_num(rs.getInt(1));
					pivo.setSubject(rs.getString(2));
					pivo.setContent(rs.getString(3));
					pivo.setWrite_date(rs.getString(4));
					pivo.setFk_member_num(rs.getInt(5));
					pivo.setFk_product_num(rs.getInt(6));
					pivo.setEmailFlag(rs.getInt(7));
					pivo.setSmsFlag(rs.getInt(8));
					pivo.setSecretFlag(rs.getInt(9));
					mvo.setName(rs.getString(10));
					mvo.setUserid(rs.getString(11));
					mvo.setEmail(aes.decrypt(rs.getString(12)));
					mvo.setMobile(aes.decrypt(rs.getString(13)));
					pivo.setMember(mvo);
				}
			rs.close();
				
			sql = " select image from product_inquiry_image_table where fk_inquiry_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, inquiry_num);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				String image = rs.getString(1);
				System.out.println("imageList요소:"+image);
				imageList.add(image);
			}
			
			pivo.setImageList(imageList);
				
		}
		catch(UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
	         
	    }
		finally {
			close();
		}
		
		return pivo;
	}

	// answer가 null이 아닌 행의 갯수 조회
	@Override
	public int answerCall(Map<String, Integer> paraMap) throws SQLException {
		int result = 0;
		String sql="";
		int beforPage = paraMap.get("beforPage");
		int type = paraMap.get("type");
		
		try {
			conn = ds.getConnection();
			if(type==0) { //상품문의 일 경우
				int product_num = paraMap.get("product_num");
				
				sql= " select count(*) "
				   + " from "
				   + " (select RON, answer"
				   + "    from( select rownum as RON, answer, subject, inquiry_num, content from product_inquiry_table where fk_product_num = ?) N";
				if(paraMap.get("start")==null) {
					
					sql+= " where N.RON between 1 and ?)T"
					    + " where T.answer is not null ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, product_num);
					pstmt.setInt(2, beforPage);
				}
				else {
					int start = paraMap.get("start");
					int end = paraMap.get("end");
					sql+= " where N.RON between ? and ?)T"
						    + " where T.answer is not null ";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, product_num);
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
				}
			}
			else if(type==1) { // 1:1문의일 경우
				int member_num = paraMap.get("member_num");
				
				sql= " select count(*) "
						   + " from "
						   + " (select RON, answer"
						   + "    from( select rownum as RON, answer, subject, one_inquiry_num, content from one_inquiry_table where fk_member_num = ?) N";
				if(paraMap.get("start")==null) {
					
					sql+= " where N.RON between 1 and ?)T"
					    + " where T.answer is not null ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, member_num);
					pstmt.setInt(2, beforPage);
				}
				else {
					int start = paraMap.get("start");
					int end = paraMap.get("end");
					sql+= " where N.RON between ? and ?)T"
						    + " where T.answer is not null ";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, member_num);
						pstmt.setInt(2, start);
						pstmt.setInt(3, end);
				}		  
			}
			
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

	// answer컬럼이 있는 테이블에서 전체 페이지 구하기
	@Override
	public int totalPage(Map<String, Integer> paraMap) throws SQLException {
		int result = 0;
		int total = 0;
		int type = paraMap.get("type");
		String sql = "";
		try {
			conn = ds.getConnection();
			if(type==0) {
				sql = " select count(*) from product_inquiry_table where fk_product_num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("product_num"));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					total+=rs.getInt(1);
				}
				rs.close();
				
				sql += " and answer is not null ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("product_num"));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					total+=rs.getInt(1);
				}
				System.out.println("총 개시글 수 :"+total);
				result = total/5;
				if(total%5!=0) result += 1 ;
			}
			else if(type==1) {
				sql = " select count(*) from one_inquiry_table where fk_member_num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("member_num"));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					total+=rs.getInt(1);
				}
				rs.close();
				
				sql += " and answer is not null ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paraMap.get("member_num"));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					total+=rs.getInt(1);
				}
				System.out.println("총 개시글 수 :"+total);
				result = total/5;
				if(total%5!=0) result += 1 ;
			}
			
		}
		finally {
			close();
		}
		
		return result;
	}

	// 후기 작성이 가능한 상품인지 조회
	@Override
	public OrderProductVO productReviewFind(Map<String, String> paraMap) throws SQLException {
		OrderProductVO opvo = null;
		ProductVO pvo = null;
		String member_num = paraMap.get("member_num");
		String product_num = paraMap.get("product_num");
		try {
			conn = ds.getConnection();
			String sql = " select OP.fk_order_num, OP.price, OP.product_count,"
					   + " P.product_num, P.product_name, P.representative_img, P.fk_category_num, P.fk_subcategory_num, "
					   + " PC.category_content, PS.subcategory_content "
					   + " from order_product_table OP "
					   + " join order_table O on OP.fk_order_num = O.order_num "
					   + " join member_table M on O.fk_member_num = M.member_num "
					   + " join product_table P on OP.fk_product_num = P.product_num "
					   + " join product_category_table PC on P.fk_category_num = PC.category_num "
					   + " join product_subcategory_table PS on P.fk_subcategory_num = PS.subcategory_num"
					   + " where O.fk_category_num = 1 and O.fk_member_num = ? and OP.fk_product_num = ? and OP.reviewFlag = 0 ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_num); 
			pstmt.setString(2, product_num);
			 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				opvo = new OrderProductVO();
				opvo.setOrder_num(rs.getInt(1));
				opvo.setPrice(rs.getInt(2));
				opvo.setCount(rs.getInt(3));
				
				pvo = new ProductVO(); pvo.setProduct_num(rs.getInt(4));
				pvo.setProduct_name(rs.getString(5));
				pvo.setRepresentative_img(rs.getString(6));
				pvo.setFk_category_num(rs.getInt(7));
				pvo.setFk_subcategory_num(rs.getInt(8));
				pvo.setCategory_content(rs.getString(9));
				pvo.setSubcategory_content(rs.getString(10));
				 
				opvo.setProduct(pvo);
				
			}
		}
		finally {
			close();
		}
		
		return opvo;
	}

	// 최근 배송지역 유무 조회
	@Override
	public Map<String, String> orderHistoryFind(int member_num) throws SQLException {
		Map<String, String> deliveryInfo = null;
		try {
			conn = ds.getConnection();
			String sql = " select recipient, recipient_mobile, recipient_postcode, recipient_address, recipient_detailaddress from order_table where fk_member_num = ? order by order_date desc ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				deliveryInfo = new HashMap<String, String>();
				deliveryInfo.put("recipient", rs.getString("recipient"));
				deliveryInfo.put("recipient_mobile", rs.getString("rscipient_mobile"));
				deliveryInfo.put("recipient_postcode", rs.getString("recipient_postcode"));
				deliveryInfo.put("recipient_address", rs.getString("recipient_address"));
				deliveryInfo.put("recipient_detailaddress", rs.getString("recipient_detailaddress"));
			}
		}
		finally {
			close();
		}
		return deliveryInfo;
	}
	
}
