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

	// 제품 목록 불러오기
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
			
			String sql = " select distinct C.category_content AS category_content, S.subcategory_content AS subcategory_content "+
						 " from product_table P JOIN product_category_table C "+
						 " ON P.fk_category_num = C.category_num "+
						 " JOIN product_subcategory_table S "+
						 " on P.fk_subcategory_num = S.subcategory_num "+
						 " where fk_category_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(fk_category_num));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				
				pvo.setCategory_content(rs.getString(1));
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
	
	
	
}
