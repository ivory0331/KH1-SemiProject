package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;



public class ProductDAO implements InterProductDAO {

	private DataSource ds; 
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
//	private AES256 aes = null;

	// 생성자 
	public ProductDAO() {
		// 암호화/복호화 키 (양방향암호화) ==> 이메일,휴대폰의 암호화/복호화
	//	String key = EncryptMyKey.KEY;
		
		try {
		    Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semiProject");
		//	aes = new AES256(key);
		} catch (NamingException e) {
			e.printStackTrace();
		} 
	//	catch (UnsupportedEncodingException e) {
	//		e.printStackTrace();
	//	}	
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

	// 페이징  안한 제품 목록 불러오기
	@Override
	public List<ProductVO> selectProductList(HashMap<String, String> paraMap) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			
			String sql = " select P.product_num AS product_num, c.category_content AS category_content, "+
						 "        S.subcategory_content AS subcategory_content, P.product_name AS product_name, "+
						 "        P.price AS price, P.stock AS stock, P.sale AS sale "+
						 " from product_table P JOIN product_category_table C "+
						 " ON P.fk_category_num = C.category_num "+
						 " JOIN product_subcategory_table S "+
						 " on P.fk_subcategory_num = S.subcategory_num "+
						 " where fk_category_num = ? "; 
			
			if(paraMap.get("fk_subcategory_num") == null) { // 전체보기
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
			}
			else if(paraMap.get("fk_subcategory_num") != null) { // 소분류 보기
				
				sql += "and fk_subcategory_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
				pstmt.setInt(2, Integer.parseInt(paraMap.get("fk_subcategory_num")));	
			}
							
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				
				pvo.setProduct_num(rs.getInt(1));
				pvo.setCategory_content(rs.getString(2));
				pvo.setSubcategory_content(rs.getString(3));
				pvo.setProduct_name(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setStock(rs.getInt(6));
				pvo.setSale(rs.getInt(7));
				
				productList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return productList;
	}

	


	
	// 대분류와 소분류 불러오기
	   @Override
	   public List<ProductVO> subcategoryList(String fk_category_num) throws SQLException {

	      List<ProductVO> subcategoryList = new ArrayList<>();
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select subcategory_num, subcategory_content " + 
	                   " from product_subcategory_table " + 
	                   " where subcategory_num like ?||'_' ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, Integer.parseInt(fk_category_num));
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	            ProductVO pvo = new ProductVO();
	            
	            pvo.setSubcategory_num(rs.getInt(1));
	            pvo.setSubcategory_content(rs.getString(2));
	            
	            subcategoryList.add(pvo);
	         }
	         
	      } finally {
	         close();
	      }
	      
	      return subcategoryList;
	   }
	

	// 소분류 불러오기
	@Override
	public String categoryInfo(String fk_category_num) throws SQLException {
		String categoryInfo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select distinct C.category_content AS category_content "+
						 " from product_table P JOIN product_category_table C "+
						 " ON P.fk_category_num = C.category_num "+
						 " where fk_category_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(fk_category_num));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				categoryInfo = rs.getString("category_content");
			}
			
		} finally {
			close();
		}
		
		return categoryInfo;
	}

	// 페이징 처리를 한 제품목록 불러오기
	@Override
	public List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap) throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		String sql ="";
		
		try {
			conn = ds.getConnection();
			
			sql = " select RNO, product_num, product_name, price, sale, representative_img " + 
				  " from " + 
				  " ( " + 
				  "    select rownum AS RNO, product_num, product_name, price, sale, representative_img " + 
				  "    from " + 
				  "     ( " + 
				  "        select  product_num, product_name, price , sale, representative_img, fk_category_num " + 
				  "        from product_table " +
				  " 	   where fk_category_num = ? ";
			
				
			if(paraMap.get("fk_subcategory_num") == null) { // 전체보기
				 
				sql += "    ) P " + 
					   " ) T " + 
					   " where  T.RNO between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
				pstmt.setInt(2, (currentShowPageNo * 9) - (9 - 1) ); // 공식
				pstmt.setInt(3, (currentShowPageNo * 9) ); // 공식
				
			}
			else if(paraMap.get("fk_subcategory_num") != null) { // 소분류 보기
				
				sql += " and fk_subcategory_num = ? "+
					   "    ) P " + 
					   " ) T " + 
					   " where  T.RNO between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
				pstmt.setInt(2, Integer.parseInt(paraMap.get("fk_subcategory_num")));	
				pstmt.setInt(3, (currentShowPageNo * 9) - (9 - 1) ); // 공식
				pstmt.setInt(4, (currentShowPageNo * 9) ); // 공식
		
			}
	
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductVO pvo = new ProductVO();
					pvo.setProduct_num(rs.getInt("product_num"));
					pvo.setProduct_name(rs.getString("product_name"));
					pvo.setPrice(rs.getInt("price"));
					pvo.setSale(rs.getInt("sale"));
					pvo.setRepresentative_img(rs.getString("representative_img"));
					
					productList.add(pvo);
				}

			pstmt = conn.prepareStatement(sql);
			
			
		} finally {
			close();
		}
		
		return productList;
	}

	// 페이징 처리를 위한 제품목록 페이지갯수 알아오기
	@Override
	public int getTotalpage(HashMap<String, String> paraMap) throws SQLException {
		int totalpage = 0;
		String sql = "";
		
		try {
			conn = ds.getConnection();
			
			sql = " select ceil( count(*)/9 ) AS totalPage "+
				  " from product_table ";
				   
			if(paraMap.get("fk_category_num") != null) {
				
				sql += " where fk_category_num = ? ";
				
				if(paraMap.get("fk_subcategory_num") == null) { // 전체보기
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
				}
				else if(paraMap.get("fk_subcategory_num") != null) { // 소분류 보기
					
					sql += "and fk_subcategory_num = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
					pstmt.setInt(2, Integer.parseInt(paraMap.get("fk_subcategory_num")));
				}
			}
			else {
				if("recommend".equalsIgnoreCase(paraMap.get("recommend"))) {
					sql += " where best_point > 0 ";
				}
				else {
					sql += " where sale > 0 ";
				}
				
				pstmt = conn.prepareStatement(sql);
			}
			
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalpage = rs.getInt("totalPage");
			
		} finally {
			close();
		}
		
		return totalpage;
	}

	
	// 로그인한 사용자의 장바구니 목록을 조회하기
	@Override
	public List<CartVO> selectProductCart(int member_num) throws SQLException {
		
		List<CartVO> cartList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql= " select A.basket_num, A.fk_product_num, A.fk_member_num, B.product_name, B.representative_img, B.price, B.sale, A.product_count" + 
						" from basket_table A join product_table B " + 
						" on A.fk_product_num = B.product_num " + 
						" where A.fk_member_num = ? " + 
						" order by A.basket_num desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt==1) {
					cartList = new ArrayList<>();
				}
				
				int basket_num = rs.getInt("basket_num");
				int fk_product_num = rs.getInt("fk_product_num");
				int fk_member_num = rs.getInt("fk_member_num");
				String product_name = rs.getString("product_name");
				String representative_img = rs.getString("representative_img");
				int price = rs.getInt("price");
				int sale = rs.getInt("sale");
				int product_count = rs.getInt("product_count");
				
				ProductVO prod = new ProductVO();
				prod.setProduct_num(fk_product_num);
				prod.setProduct_name(product_name);
				prod.setRepresentative_img(representative_img);
				prod.setPrice(price);
				prod.setSale(sale);
				prod.setTotalPrice(price,sale,product_count);
				
				CartVO cvo = new CartVO();
				cvo.setBasket_num(basket_num);
				cvo.setMember_num(fk_member_num);
				cvo.setProduct_num(fk_product_num);
				cvo.setProduct_count(product_count);
				cvo.setProd(prod);
				
				cartList.add(cvo);
				
			} // end of while------------------------------------------------------
			
			
		} finally {
			close();
		}
		
		
		
		return cartList;
	}

	
	// 로그인한 사용자의 장바구니에 담긴 주문총액합계
	@Override
	public HashMap<String, String> selectSumCartPricePoint(int member_num) throws SQLException {
		
		HashMap<String, String> sumMap = new HashMap<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select nvl(sum(A.product_count *  (B.price - B.price * (B.sale/100) ) ), 0 ) AS SUMTOTALPRICE " + 
						 " from basket_table A join product_table B " + 
						 " on A.fk_product_num = B.product_num " + 
						 " where A.fk_member_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			sumMap.put("SUMTOTALPRICE", rs.getString("SUMTOTALPRICE"));
			
		} finally {
			close();
		}
		
		return sumMap;
	}

	
	// 장바구니 테이블에서 특정제품을 장바구니에서 비우기  
	@Override
	public int delCart(String cartno) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from basket_table " + 
						 " where basket_num = ? ";
					   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cartno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}

	
	// 장바구니 테이블에서 특정제품을 장바구니에서 주문량 증감시키기 
	@Override
	public int updateCart(String cartno, String oqty) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update basket_table set product_count = ? "
					   + " where basket_num = ? ";
					   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, oqty);
			pstmt.setString(2, cartno);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}


	
	// 페이징 처리를 한 신상품 목록을 조회하기
	@Override
	public List<ProductVO> selectNewList(HashMap<String, String> paraMap) throws SQLException {
		
		List<ProductVO> newprodList = new ArrayList<>();
		String sql ="";
		
		try {
			conn = ds.getConnection();
			
			sql = " select RNO, product_num, product_name, price, sale, representative_img " + 
				  " from " + 
				  " ( " + 
				  "     select rownum AS RNO, product_num, product_name, price, sale, representative_img " + 
				  "     from " + 
				  "     ( " + 
				  "        select  product_num, product_name, price, sale, representative_img " + 
				  "        from product_table " + 
				  "        order by registerdate desc " + 
				  "    ) V " + 
				  " ) T " + 
				  " where T.RNO between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				pstmt.setInt(1, (currentShowPageNo * 9) - (9 - 1) ); // 공식
				pstmt.setInt(2, (currentShowPageNo * 9) ); // 공식
	
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductVO pvo = new ProductVO();
					pvo.setProduct_num(rs.getInt("product_num"));
					pvo.setProduct_name(rs.getString("product_name"));
					pvo.setPrice(rs.getInt("price"));
					pvo.setSale(rs.getInt("sale"));
					pvo.setRepresentative_img(rs.getString("representative_img"));
					
					newprodList.add(pvo);
				}

			pstmt = conn.prepareStatement(sql);
			
			
		} finally {
			close();
		}
		
		return newprodList;

		
	}

	
	// 페이징 처리를 한 세일품목 조회하기
	@Override
	public List<ProductVO> selectSale(HashMap<String, String> paraMap) throws SQLException {
		
		List<ProductVO> saleprodList = new ArrayList<>();
		String sql ="";
		
		try {
			conn = ds.getConnection();
			
			sql = " select RNO, product_num, product_name, price, sale, representative_img " + 
				  " from " + 
				  " ( " + 
				  "     select rownum AS RNO, product_num, product_name, price, sale, representative_img " + 
				  "     from " + 
				  "     ( " + 
				  "        select  product_num, product_name, price, sale, representative_img " + 
				  "        from product_table " + 
				  "        where sale > 0 " + 
				  "    ) V " + 
				  " ) T " + 
				  " where T.RNO between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				pstmt.setInt(1, (currentShowPageNo * 9) - (9 - 1) ); // 공식
				pstmt.setInt(2, (currentShowPageNo * 9) ); // 공식
	
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductVO pvo = new ProductVO();
					pvo.setProduct_num(rs.getInt("product_num"));
					pvo.setProduct_name(rs.getString("product_name"));
					pvo.setPrice(rs.getInt("price"));
					pvo.setSale(rs.getInt("sale"));
					pvo.setRepresentative_img(rs.getString("representative_img"));
					
					saleprodList.add(pvo);
				}
				
			pstmt = conn.prepareStatement(sql);
			
		} finally {
			close();
		}
		
		return saleprodList;

	}

	
	// 선택한 옵션에 맞게 상품 리스트 보여주기
	@Override
	public List<ProductVO> selectOption(HashMap<String, String> paraMap) throws SQLException {
		List<ProductVO> selectOption = new ArrayList<>();
		String sql ="";
		
		try {
			conn = ds.getConnection();
			
			sql = " select RNO, product_num, product_name, price, sale, representative_img " + 
				  " from " + 
				  " ( " + 
				  "    select rownum AS RNO, product_num, product_name, price, sale, representative_img " + 
				  "    from " + 
				  "     ( " + 
				  "        select  product_num, product_name, price , sale, representative_img, fk_category_num " + 
				  "        from product_table " +
				  " 	   where fk_category_num = ? ";
			
				
			if(paraMap.get("fk_subcategory_num") == null ) { // 전체보기
				
				 if("registerdate".equalsIgnoreCase(paraMap.get("optionSelect"))) {
					sql += " order by registerdate desc " +
						   "    ) P " + 
						   " ) T " + 
						   " where T.RNO between ? and ? ";
					
					pstmt = conn.prepareStatement(sql);
					int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
					pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
					pstmt.setInt(2, (currentShowPageNo * 9) - (9 - 1) ); // 공식
					pstmt.setInt(3, (currentShowPageNo * 9) ); // 공식
				 }
				 else {
					sql += " order by price "+paraMap.get("optionSelect")+
						   "    ) P " + 
						   " ) T " + 
						   " where T.RNO between ? and ? ";
					
					pstmt = conn.prepareStatement(sql);
					int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
					pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
					pstmt.setInt(2, (currentShowPageNo * 9) - (9 - 1) ); // 공식
					pstmt.setInt(3, (currentShowPageNo * 9) ); // 공식
				 }
			}
			else if(paraMap.get("fk_subcategory_num") != null ) { // 소분류 보기
				
				if("registerdate".equalsIgnoreCase(paraMap.get("optionSelect"))) {
					
					sql += " and fk_subcategory_num = ? "+
						   " order by registerdate desc "+
						   "    ) P " + 
						   " ) T " + 
						   " where T.RNO between ? and ? ";
					
					pstmt = conn.prepareStatement(sql);
					int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
					pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
					pstmt.setInt(2, Integer.parseInt(paraMap.get("fk_subcategory_num")));	
					pstmt.setInt(3, (currentShowPageNo * 9) - (9 - 1) ); // 공식
					pstmt.setInt(4, (currentShowPageNo * 9) ); // 공식
				}
				else {
					sql += " and fk_subcategory_num = ? "+
						   " order by price "+paraMap.get("optionSelect")+
						   "    ) P " + 
						   " ) T " + 
						   " where T.RNO between ? and ? ";
					
					pstmt = conn.prepareStatement(sql);
					int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
					pstmt.setInt(1, Integer.parseInt(paraMap.get("fk_category_num")));
					pstmt.setInt(2, Integer.parseInt(paraMap.get("fk_subcategory_num")));
					pstmt.setInt(3, (currentShowPageNo * 9) - (9 - 1) ); // 공식
					pstmt.setInt(4, (currentShowPageNo * 9) ); // 공식
				}
			}
	
				System.out.println(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductVO pvo = new ProductVO();
					pvo.setProduct_num(rs.getInt("product_num"));
					pvo.setProduct_name(rs.getString("product_name"));
					pvo.setPrice(rs.getInt("price"));
					pvo.setSale(rs.getInt("sale"));
					pvo.setRepresentative_img(rs.getString("representative_img"));
					
					selectOption.add(pvo);
				}

			pstmt = conn.prepareStatement(sql);
			
			
		} finally {
			close();
		}
		
		return selectOption;

	}

	
	// 페이징 처리를 한 추천상품 조회하기
	@Override
	public List<ProductVO> recommendList(HashMap<String, String> paraMap) throws SQLException {
		
		List<ProductVO> recommendList = new ArrayList<>();
		String sql ="";
		
		try {
			conn = ds.getConnection();
			
			sql = " select RNO, product_num, product_name, price, sale, representative_img " + 
				  " from " + 
				  " ( " + 
				  "     select rownum AS RNO, product_num, product_name, price, sale, representative_img " + 
				  "     from " + 
				  "     ( " + 
				  "        select  product_num, product_name, price, sale, representative_img " + 
				  "        from product_table " + 
				  "		   where best_point > 0 "+
				  "        order by registerdate desc " + 
				  "    ) V " + 
				  " ) T " + 
				  " where T.RNO between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				pstmt.setInt(1, (currentShowPageNo * 9) - (9 - 1) ); // 공식
				pstmt.setInt(2, (currentShowPageNo * 9) ); // 공식
	
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductVO pvo = new ProductVO();
					pvo.setProduct_num(rs.getInt("product_num"));
					pvo.setProduct_name(rs.getString("product_name"));
					pvo.setPrice(rs.getInt("price"));
					pvo.setSale(rs.getInt("sale"));
					pvo.setRepresentative_img(rs.getString("representative_img"));
					
					recommendList.add(pvo);
				}

			pstmt = conn.prepareStatement(sql);
			
			
		} finally {
			close();
		}
		
		return recommendList;

	}




}
