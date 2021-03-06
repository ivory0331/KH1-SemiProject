package manager.model;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import main.model.ImageVO;
import product.model.ProductVO;

public class ProductDAO implements InterProductDAO {

		private DataSource ds; 	
		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		

		// 생성자 
		public ProductDAO() {

			try {
			    Context initContext = new InitialContext();
				Context envContext  = (Context)initContext.lookup("java:/comp/env");
				ds = (DataSource)envContext.lookup("jdbc/semiProject");
			} catch (NamingException e) {
				e.printStackTrace();
			} 
		} 
		 
		
		// 자원반납
		public void close() {
			try {
				if(rs != null) { rs.close(); rs=null; }
				if(pstmt != null) { pstmt.close(); pstmt=null; } 
				if(conn != null) { conn.close(); conn=null; }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		
		// 전체 상품 조회
		@Override
		public List<ProductVO> selectAllProduct() throws SQLException {
			
			List<ProductVO> productList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select P.product_num as PRODUCT_NUM, c.category_content as CATEGORY_CONTENT, " 
									+" S.subcategory_content as SUBCATEGORY_CONTENT, "
									+" P.representative_img as REPRESENTATIVE_IMG, " 
									+" P.product_name as PRODUCT_NAME, "
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
					pvo.setRepresentative_img(rs.getString("REPRESENTATIVE_IMG"));
					pvo.setProduct_name(rs.getString("PRODUCT_NAME"));
					pvo.setPrice(rs.getInt("PRICE"));				
					pvo.setStock(rs.getInt("STOCK"));
		            
					productList.add(pvo);				
				}						
				
			} finally {
				close();
			}
			
			
			return productList;
		}
		
		
		
		// 검색 처리
		@Override
		public List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap) throws SQLException {
			
			List<ProductVO> productList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();

				
				String sql = " select  RNO, PRODUCT_NUM, CATEGORY_CONTENT, SUBCATEGORY_CONTENT, REPRESENTATIVE_IMG, PRODUCT_NAME, PRICE, STOCK  "
							+" from "
							+" ( select rownum AS RNO,PRODUCT_NUM, CATEGORY_CONTENT, SUBCATEGORY_CONTENT, REPRESENTATIVE_IMG, PRODUCT_NAME, PRICE, STOCK "
							+"   from "
							+"     ( select P.PRODUCT_NUM, c.category_content as CATEGORY_CONTENT, " 
											+" S.subcategory_content as SUBCATEGORY_CONTENT, P.representative_img as REPRESENTATIVE_IMG, P.PRODUCT_NAME, "
											+ " P.PRICE, P.STOCK " 
									+" from ( select product_num as PRODUCT_NUM, fk_category_num, fk_subcategory_num, representative_img, product_name as PRODUCT_NAME, price as PRICE, stock as STOCK "
										  + " from product_table ";
				
				String searchWord = paraMap.get("searchWord");
				String fk_category_num = paraMap.get("fk_category_num");
				String fk_subcategory_num = paraMap.get("fk_subcategory_num");
				
				// 1. 대분류만 있고
				if( !"0".equals(fk_category_num) && "0".equals(fk_subcategory_num)) {				
					sql+= " where FK_CATEGORY_NUM = ? ";
					
					if(searchWord !="") {	//대분류에 검색어가 있다면					
						sql += " and PRODUCT_NAME like '%'||?||'%' ";						
					}
					
				}

				// 2. 소분류가 있고
				else if( !"0".equals(fk_category_num) && !"0".equals(fk_subcategory_num)) {
					sql+= " where FK_SUBCATEGORY_NUM = ? ";
					if(searchWord !="") {	//소분류에 검색어가 있다면					
						sql += " and PRODUCT_NAME like '%'||?||'%' ";						
					}
				}
				
				
				// 3. 분류 구분 없고
				else{
					if(searchWord !="") {	//검색어가 있다면					
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
					if(searchWord !="") {			
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
				else if( !"0".equals(fk_category_num) && !"0".equals(fk_subcategory_num)) {
					if(searchWord !="") {			
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
					if(searchWord !="") {		
						pstmt.setString(1, searchWord);
						pstmt.setInt(2, (currentShowPageNo*sizePerPage)-sizePerPage+1);
						pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
					}else {
						pstmt.setInt(1, (currentShowPageNo*sizePerPage)-sizePerPage+1);
						pstmt.setInt(2, (currentShowPageNo*sizePerPage) );
					}
					
				}
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductVO pvo = new ProductVO();
					pvo.setProduct_num(rs.getInt("PRODUCT_NUM"));
					pvo.setCategory_content(rs.getString("CATEGORY_CONTENT"));
					pvo.setSubcategory_content(rs.getString("SUBCATEGORY_CONTENT"));
					pvo.setRepresentative_img(rs.getString("REPRESENTATIVE_IMG"));
					pvo.setProduct_name(rs.getString("PRODUCT_NAME"));
					pvo.setPrice(rs.getInt("PRICE"));
					pvo.setStock(rs.getInt("STOCK"));	
					
					productList.add(pvo);
				}		
				
			} catch(Exception e){
				e.printStackTrace();
			} finally {
				close();
			}
			
			return productList;
		}
		
		

		//전체페이지 구하기
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
		public boolean productNameDuplicateCheck(String productName, String productNum) throws SQLException {
			boolean isUse;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select product_name from product_table where product_name = ? and product_num !=?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, productName);
				pstmt.setString(2, productNum);
				
				rs = pstmt.executeQuery();
				
				isUse = !rs.next();
				
			} finally {
				close();
			}
			
			return isUse;	
		
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
		
		
		
		

	  
	  // 소분류 카테고리
	  
	  @Override public List<HashMap<String, String>> getSubCategoryList(String fk_category_num) throws SQLException {
	  
		  List<HashMap<String, String>> subCategoryList = new ArrayList<>();
		  
		  
		  try { 
			  conn = ds.getConnection();
		  
			  String sql = " select subcategory_num, subcategory_content " +
					  		" from product_subcategory_table " + 
					  		" where subcategory_num like ?||'%' " +
					  		" order by subcategory_num asc ";
			  
			  pstmt = conn.prepareStatement(sql);

			  pstmt.setString(1, fk_category_num); 
			  
			  rs = pstmt.executeQuery();
			  
			  while(rs.next()) { 
				  HashMap<String, String> map = new HashMap<String, String>(); 
			  
				  map.put("subcategory_num", rs.getString("subcategory_num"));
				  map.put("subcategory_content", rs.getString("subcategory_content"));
				  
				  subCategoryList.add(map);
			  
			  }
			  
		  } finally { 
			  close(); 
		  }
			  
		  return subCategoryList;
	  
	  }


	 
		// 제품등록 채번
		@Override
		public int getPnumOfProduct() throws SQLException {
			
			int pnum = 0;
			
			try {
				 conn = ds.getConnection();
				 
				 String sql = " select last_number from user_sequences where SEQUENCE_NAME = 'SEQ_PRODUCT_TABLE'";
						 
				 pstmt = conn.prepareStatement(sql);
				 rs = pstmt.executeQuery();
				 			 
				 rs.next();
				 pnum = rs.getInt(1);
			
			} finally {
				close();
			}
			
			return pnum;	
			
		}
		
		
		// 제품 신상 등록
		@Override
		public int productInsert(ProductVO pvo) throws SQLException {
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = "insert into product_table(product_num, product_name, price, stock "+
						                                " ,origin, packing, unit, sale, best_point "+
						                                " ,seller, seller_phone, explain, representative_img, fk_category_num, fk_subcategory_num, weight, shelf, information ) "+
						     " values(seq_product_table.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, pvo.getProduct_name());
				pstmt.setInt(2, pvo.getPrice());    
				pstmt.setInt(3, pvo.getStock()); 
				pstmt.setString(4, pvo.getOrigin());    
				pstmt.setString(5, pvo.getPacking()); 
				pstmt.setString(6, pvo.getUnit()); 
				pstmt.setInt(7, pvo.getSale());
				pstmt.setInt(8, pvo.getBest_point());
				pstmt.setString(9, pvo.getSeller());
				pstmt.setString(10, pvo.getSeller_phone());
				pstmt.setString(11, pvo.getExplain());
				pstmt.setString(12, pvo.getRepresentative_img());
				pstmt.setInt(13, pvo.getFk_category_num());
				pstmt.setInt(14, pvo.getFk_subcategory_num());
				pstmt.setString(15, pvo.getWeight());
				pstmt.setString(16, pvo.getShelf());
				pstmt.setString(17, pvo.getInformation());
					
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;					
		}


		// 제품 신상 상세이미지 등록
		@Override
		public int productImageInsert(int product_num, String detail_img) throws SQLException {
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " insert into product_image_table(product_image_num,fk_product_num, image) "
							+" values(seq_product_image.nextval,?,?) ";
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, product_num);
				pstmt.setString(2, detail_img);
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
		}

	
		
		// 제품 상세 보기
		@Override
		public ProductVO detailProduct(String product_num) throws SQLException {
			
			ProductVO pvo = new ProductVO();
			
			try {
				conn = ds.getConnection();
				
				String sql = "select P.product_num as PRODUCT_NUM, c.category_content as CATEGORY_CONTENT, S.subcategory_content as SUBCATEGORY_CONTENT, " + 
						" P.fk_category_num as CATEGORY_NUM, P.fk_subcategory_num as SUBCATEGORY_NUM, "+
						" P.product_name as PRODUCT_NAME, P.unit as UNIT, P.packing as PACKING, P.origin as ORIGIN, P.price as PRICE, P.sale as SALE, " + 
						" P.best_point as BEST_POINT, P.seller as SELLER, P.seller_phone as SELLER_PHONE, P.stock as STOCK, " + 
						" P.explain as EXPLAIN, P.representative_img as REPRESENTATIVE_IMG, P.weight as WEIGHT, P.shelf as SHELF, P.information as INFORMATION " + 
						" from product_table P join product_category_table C " + 
						" on P.fk_category_num = C.category_num " + 
						" join product_subcategory_table S " + 
						" on P.fk_subcategory_num = S.subcategory_num " +
						" where product_num = ?";
				

				pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, product_num);
				
				rs = pstmt.executeQuery();				
				rs.next();
			
				pvo.setProduct_num(rs.getInt("PRODUCT_NUM"));
				pvo.setCategory_content(rs.getString("CATEGORY_CONTENT"));
				pvo.setSubcategory_content(rs.getString("SUBCATEGORY_CONTENT"));
				pvo.setFk_category_num(rs.getInt("CATEGORY_NUM"));
				pvo.setFk_subcategory_num(rs.getInt("SUBCATEGORY_NUM"));
				pvo.setProduct_name(rs.getString("PRODUCT_NAME"));
				pvo.setUnit(rs.getString("UNIT"));
				pvo.setPacking(rs.getString("PACKING"));
				pvo.setOrigin(rs.getString("origin"));
				pvo.setPrice(rs.getInt("PRICE"));
				pvo.setSale(rs.getInt("SALE"));
				pvo.setBest_point(rs.getInt("BEST_POINT"));
				pvo.setSeller(rs.getString("SELLER"));
				pvo.setSeller_phone(rs.getString("SELLER_PHONE"));
				pvo.setStock(rs.getInt("STOCK")); 
				pvo.setRepresentative_img(rs.getString("REPRESENTATIVE_IMG"));
				pvo.setWeight(rs.getString("WEIGHT"));
				pvo.setShelf(rs.getString("SHELF"));
				
				String information = rs.getString("INFORMATION");
				if(information != null && !information.trim().isEmpty()) {
					information = information.replaceAll("&gt;", ">");
					information = information.replaceAll("&lt;", "<");
					information = information.replaceAll("<br>", "\r\n");
				}
				
				
				String explain = rs.getString("EXPLAIN");
				if(explain != null && !explain.trim().isEmpty()) {
					explain = explain.replaceAll("&gt;", ">");
					explain = explain.replaceAll("&lt;", "<");
					explain = explain.replaceAll("<br>", "\r\n");
				}
				
				
				pvo.setExplain(explain);
				pvo.setInformation(information);						
				
			} finally {
				close();
			}
			
			
			return pvo;
		}


		// 상세이미지 불러오기
		@Override
		public List<ImageVO> detailProductImg(String product_num) throws SQLException {
			
			List<ImageVO> imageList = new ArrayList<ImageVO>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select product_image_num, image "
							+" from product_image_table "
							+" where fk_product_num= ? ";

				pstmt = conn.prepareStatement(sql);	
				
				pstmt.setString(1, product_num);
				
				rs = pstmt.executeQuery();	
				
				while(rs.next()) {					
					ImageVO img = new ImageVO();
					img.setImg_num(rs.getInt("product_image_num"));
					img.setImage(rs.getString("image"));
					imageList.add(img);
				
				}
													
				
			} finally {
				close();
			}
						
			return imageList;		
			
		}


		
		// 제품 수정
		@Override
		public int productUpdate(ProductVO pvo) throws SQLException {
			
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String representative_img = pvo.getRepresentative_img();
				
				String sql = " update product_table set ";
				
				if(representative_img!=null) {
					sql += " representative_img=?, ";
				}
						
				sql += " fk_category_num = ?, fk_subcategory_num=?, product_name=?, "
					+" unit=?,packing=?,origin=?,price=?,sale=?,best_point=?,seller=?,seller_phone=?,stock=?,explain=?,weight=?,shelf=?,information=? "
					+" where product_num=? ";					
				
				pstmt = conn.prepareStatement(sql);
				
				if(representative_img!=null) {
					pstmt.setString(1, pvo.getRepresentative_img());
					pstmt.setInt(2, pvo.getFk_category_num());
					pstmt.setInt(3, pvo.getFk_subcategory_num());
					pstmt.setString(4, pvo.getProduct_name());
					pstmt.setString(5, pvo.getUnit()); 
					pstmt.setString(6, pvo.getPacking()); 
					pstmt.setString(7, pvo.getOrigin());    
					pstmt.setInt(8, pvo.getPrice());    
					pstmt.setInt(9, pvo.getSale());
					pstmt.setInt(10, pvo.getBest_point());
					pstmt.setString(11, pvo.getSeller());
					pstmt.setString(12, pvo.getSeller_phone());
					pstmt.setInt(13, pvo.getStock()); 
					pstmt.setString(14, pvo.getExplain());
					pstmt.setString(15, pvo.getWeight());
					pstmt.setString(16, pvo.getShelf());
					pstmt.setString(17, pvo.getInformation());
					pstmt.setInt(18, pvo.getProduct_num());
					
				}else {
					pstmt.setInt(1, pvo.getFk_category_num());
					pstmt.setInt(2, pvo.getFk_subcategory_num());
					pstmt.setString(3, pvo.getProduct_name());
					pstmt.setString(4, pvo.getUnit()); 
					pstmt.setString(5, pvo.getPacking()); 
					pstmt.setString(6, pvo.getOrigin());    
					pstmt.setInt(7, pvo.getPrice());    
					pstmt.setInt(8, pvo.getSale());
					pstmt.setInt(9, pvo.getBest_point());
					pstmt.setString(10, pvo.getSeller());
					pstmt.setString(11, pvo.getSeller_phone());
					pstmt.setInt(12, pvo.getStock()); 
					pstmt.setString(13, pvo.getExplain());
					pstmt.setString(14, pvo.getWeight());
					pstmt.setString(15, pvo.getShelf());
					pstmt.setString(16, pvo.getInformation());
					pstmt.setInt(17, pvo.getProduct_num());
					
				}
								
					
				result = pstmt.executeUpdate();
				
				
			} finally {
				close();
			}
			
			return result;		
			
		}


		
		// 제품 수정 상세 이미지
		@Override
		public int productImageReplace(String detail_img, String old_name) throws SQLException {
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update product_image_table set image=? "
							+" where product_image_num =? ";
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, detail_img);
				pstmt.setString(2, old_name);
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
		}


		@Override
		public int productImageUpdate(int product_num, String detail_img) throws SQLException {
			int result=0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update product_image_table set image=? "
							+" where fk_product_num=? ";
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, detail_img);
				pstmt.setInt(2, product_num);
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
		}



		// 제품 상세 이미지 삭제
		@Override
		public int productImageDelete(String old_name) throws SQLException {
			int n = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update product_image_table set image='' where product_image_num =? ";
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, old_name);
				
				n = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			
			return n;
		}
		
	}

	

