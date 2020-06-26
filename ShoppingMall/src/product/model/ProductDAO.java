package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;


public class ProductDAO implements InterProductDAO {

	private DataSource ds; 	
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
	public List<ProductVO> categoryList(String fk_category_num) throws SQLException {
		
		List<ProductVO> categoryList = new ArrayList<>();

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
				
				categoryList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return categoryList;
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
						 " where fk_category_num = ?";
			
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

	
	// 대분류 카테고리 abstract
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {
		
		List<HashMap<String, String>> categoryList = new ArrayList<>(); 
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select category_num, category_content "  
			 		    + " from product_category_table "
			 		    + " order by category_num asc ";
			 		    
			pstmt = conn.prepareStatement(sql);
					
			rs = pstmt.executeQuery();
						
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("category_num", rs.getString("category_num"));
				map.put("category_content", rs.getString("category_content"));
				
				categoryList.add(map);
				
			}
			
		} finally {
			close();
		}	
		
		return categoryList;
		
	}
	
	
	
	
	
	
	
	//////////////////////////////////// 매니저 진하
	// 전체 상품 조회
	@Override
	public List<ProductVO> selectAllProduct() throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
	// 페이징 처리를 한 제품목록 불러오기
	@Override
	public List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap) throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		String sql ="";
		
		try {
			conn = ds.getConnection();
			
			String sql = " select P.product_num as PRODUCT_NUM, c.category_content as CATEGORY_CONTENT, " 
								+" S.subcategory_content as SUBCATEGORY_CONTENT, P.product_name as PRODUCT_NAME, "
								+" P.price as PRICE, P.stock as STOCK "
						+" from product_table P join product_category_table C "
							+" on P.fk_category_num = C.category_num "
							+" join product_subcategory_table S "
							+" on P.fk_subcategory_num = S.subcategory_num "
						+" order by product_num desc ";
			

			pstmt = conn.prepareStatement(sql);			
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				pvo.setProduct_num(rs.getInt("PRODUCT_NUM"));
				pvo.setCategory_content(rs.getString("CATEGORY_CONTENT"));
				pvo.setSubcategory_content(rs.getString("SUBCATEGORY_CONTENT"));
				pvo.setProduct_name(rs.getString("PRODUCT_NAME"));
				pvo.setPrice(rs.getInt("PRICE"));				
				pvo.setStock(rs.getInt("STOCK"));
	            
				productList.add(pvo);				
			}						
			sql = " select RNO, product_num, product_name, price, sale, representative_img " + 
				  " from " + 
				  " ( " + 
				  "    select rownum AS RNO, product_num, product_name, price, sale, representative_img " + 
				  "    from " + 
				  "     ( " + 
				  "        select  product_num, product_name, price , sale, representative_img, fk_category_num " + 
				  "        from product_table "+ 
				  "        where fk_category_num = ? "; 

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
		
		
		return null;
	}
	
	
	
	// 검색 처리
	@Override
	public List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();

			
			String sql = " select  RNO, PRODUCT_NUM, CATEGORY_CONTENT, SUBCATEGORY_CONTENT, PRODUCT_NAME, PRICE, STOCK  "
						+" from "
						+" ( select rownum AS RNO,PRODUCT_NUM, CATEGORY_CONTENT, SUBCATEGORY_CONTENT, PRODUCT_NAME, PRICE, STOCK "
						+"   from "
						+"     ( select P.PRODUCT_NUM, c.category_content as CATEGORY_CONTENT, " 
										+" S.subcategory_content as SUBCATEGORY_CONTENT, P.PRODUCT_NAME, "
										+ " P.PRICE, P.STOCK " 
								+" from ( select product_num as PRODUCT_NUM, fk_category_num, fk_subcategory_num, product_name as PRODUCT_NAME, price as PRICE, stock as STOCK "
									  + " from product_table ";
			
			String searchWord = paraMap.get("searchWord");
			String fk_category_num = paraMap.get("fk_category_num");
			String fk_subcategory_num = paraMap.get("fk_subcategory_num");
			
			// 1. 대분류만 있고
			if( !"0".equals(fk_category_num)&&"0".equals(fk_subcategory_num)) {				
				sql+= " where FK_CATEGORY_NUM = ? ";
				
				if(searchWord !=null) {	//대분류에 검색어가 있다면					
					sql += " and PRODUCT_NAME like '%'||?||'%' ";						
				}
				
			}

			// 2. 소분류가 있고
			if( !"0".equals(fk_category_num)&&!"0".equals(fk_subcategory_num)) {
				sql+= " where FK_SUBCATEGORY_NUM = ? ";
				if(searchWord !=null) {	//소분류에 검색어가 있다면					
					sql += " and PRODUCT_NAME like '%'||?||'%' ";						
				}
			}
			
			
			// 3. 분류 구분 없고
			else{
				if(searchWord !=null) {	//검색어가 있다면					
					sql += " where PRODUCT_NAME like '%'||?||'%' ";						
				}			
			}
			
			
			sql += 		" ) P join product_category_table C "
					+" on P.fk_category_num = C.category_num " 
					+" join product_subcategory_table S " 
					+" on P.fk_subcategory_num = S.subcategory_num "
					+ 	"       order by PRODUCT_NUM desc "
					+"     )V "
					+" )T "
					+" where T.RNO between ? and ? ";					
			
			pstmt = conn.prepareStatement(sql);			
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			
			//1.
			if( !"0".equals(fk_category_num)&&"0".equals(fk_subcategory_num)) {
				if(searchWord !=null) {			
					pstmt.setString(1, fk_category_num);
					pstmt.setString(2, searchWord);
					pstmt.setInt(3, (currentShowPageNo*sizePerPage)-sizePerPage+1);
					pstmt.setInt(4, (currentShowPageNo*sizePerPage) );
				}else {
					pstmt.setString(1, fk_category_num);
					pstmt.setInt(2, (currentShowPageNo*sizePerPage)-sizePerPage+1);
					pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
				}				
			}			
			
			
			//2.
			else if( !"0".equals(fk_category_num)&&!"0".equals(fk_subcategory_num)) {
				if(searchWord !=null) {			
					pstmt.setString(1, fk_subcategory_num);
					pstmt.setString(2, searchWord);
					pstmt.setInt(3, (currentShowPageNo*sizePerPage)-sizePerPage+1);
					pstmt.setInt(4, (currentShowPageNo*sizePerPage) );
				}else {
					pstmt.setString(1, fk_subcategory_num);
					pstmt.setInt(2, (currentShowPageNo*sizePerPage)-sizePerPage+1);
					pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
				}
				
			}	
			
			//3.
			if( "0".equals(fk_category_num)&&"0".equals(fk_subcategory_num)) {
				if(searchWord !=null) {		
					pstmt.setString(1, searchWord);
					pstmt.setInt(2, (currentShowPageNo*sizePerPage)-sizePerPage+1);
					pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
				}else {
					pstmt.setInt(1, (currentShowPageNo*sizePerPage)-sizePerPage+1);
					pstmt.setInt(2, (currentShowPageNo*sizePerPage) );
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
				  " from product_table "+
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
				pvo.setProduct_num(rs.getInt("PRODUCT_NUM"));
				pvo.setCategory_content(rs.getString("CATEGORY_CONTENT"));
				pvo.setSubcategory_content(rs.getString("SUBCATEGORY_CONTENT"));
				pvo.setProduct_name(rs.getString("PRODUCT_NAME"));
				pvo.setPrice(rs.getInt("PRICE"));
				pvo.setStock(rs.getInt("STOCK"));	
				
				productList.add(pvo);
			}		
			
		} catch(Exception e){
			e.printStackTrace();
			rs.next();
			
			totalpage = rs.getInt("totalPage");
			
		} finally {
			close();
		}
		
		return productList;
	}
	
	

	//전체 페이지 구하기
	@Override
	public int getTotalPage(HashMap<String, String> paraMap) throws SQLException{
		
		int totalPage = 0;
		
		try {
			conn=ds.getConnection();
			
			String sql = " select ceil(count(*)/?) as totalPage "
						+" from product_table ";
			
			String fk_category_num = paraMap.get("fk_category_num");
			String fk_subcategory_num = paraMap.get("fk_subcategory_num");
			String searchWord = paraMap.get("searchWord");
			
			System.out.println(fk_category_num);
			System.out.println(fk_subcategory_num);
			System.out.println(searchWord);

			
			
			//1. 대분류가 있다면
			if( !"0".equals(fk_category_num)&&"0".equals(fk_subcategory_num)) {
				sql+= " where FK_CATEGORY_NUM = ? ";
				if(searchWord !=null) {	
					sql += " and PRODUCT_NAME like '%'||?||'%' ";						
				}
			}
			
			//2. 소분류가 있다면	
			else if( !"0".equals(fk_category_num)&&!"0".equals(fk_subcategory_num)) {
				sql+= " where FK_SUBCATEGORY_NUM = ? ";
				if(searchWord !=null) {	
					sql += " and PRODUCT_NAME like '%'||?||'%' ";						
				}
			}
			
			// 3. 분류없이 
			else if( "0".equals(fk_category_num)&&"0".equals(fk_subcategory_num)) {
				if(searchWord !=null) {	
					sql += " where PRODUCT_NAME like '%'||?||'%' ";		
				}
			}			
			
			pstmt = conn.prepareStatement(sql);
			
			
			//1.
			if( !"0".equals(fk_category_num)&&"0".equals(fk_subcategory_num)) {	
				pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
				pstmt.setString(2, fk_category_num);
				if(searchWord !=null) {					
					pstmt.setString(3, searchWord);
				}
			}
			
			
			//2.
			else if( !"0".equals(fk_category_num)&&!"0".equals(fk_subcategory_num)) {
				pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
				pstmt.setString(2, fk_subcategory_num);
				if(searchWord !=null) {					
					pstmt.setString(3, searchWord);
				}
			}		
			
			
			//3.
			else if( "0".equals(fk_category_num)&&"0".equals(fk_subcategory_num)) {
				if(searchWord !=null) {	
					pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
					pstmt.setString(2, searchWord);	
				}else {
					pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));

				}
			}
						
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
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
		
		
		return totalPage;
	}


	
	// 선택 상품 삭제 
	@Override
	public int productDelete(String product_num) throws SQLException {
		
		int result = 0;
		
		try {		
			
			conn = ds.getConnection();			
			String sql = "delete from product_table where product_num= ?";			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, product_num);			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
			
		
		return result;	
		
	}


	// 상품명 중복 확인
	@Override
	public boolean productNameDuplicateCheck(String productName) throws SQLException {
		boolean isUse;
		
		return cartList;
	}

	
	// 로그인한 사용자의 장바구니에 담긴 주문총액합계
	@Override
	public HashMap<String, String> selectSumCartPricePoint(int member_num) throws SQLException {
		
		HashMap<String, String> sumMap = new HashMap<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select product_name from product_table where product_name = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productName);
			
			rs = pstmt.executeQuery();
			
			isUse = !rs.next();
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
		
		return isUse;	
	
	}

	
	
	// 소분류 카테고리	
	@Override
	public List<HashMap<String, String>> getSubCategoryList(String fk_category_num) throws SQLException {	
		
		List<HashMap<String, String>> subcategoryList = new ArrayList<>(); 
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select subcategory_num, subcategory_content "  
			 		    + " from product_subcategory_table "
			 		    + " where subcategory_num like ?||'%' "
			 		    + " order by subcategory_num asc ";
			 		    
			pstmt = conn.prepareStatement(sql);
					
			rs = pstmt.executeQuery();
						
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("subcategory_num", rs.getString("subcategory_num"));
				map.put("subcategory_content", rs.getString("subcategory_content"));
				
				subcategoryList.add(map);
				
			}
			
		} finally {
			close();
		}	
		
		return subcategoryList;	
		
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
	
	
	
}
