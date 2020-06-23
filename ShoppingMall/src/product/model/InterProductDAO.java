package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterProductDAO {

	// 페이징 안한 제품 목록 불러오기
	List<ProductVO> selectProductList(HashMap<String, String> paraMap) throws SQLException;

	// 대분류 불러오기
	String categoryInfo(String fk_category_num) throws SQLException;

	// 소분류 불러오기
	List<ProductVO> categoryList(String fk_category_num) throws SQLException;

	// 페이징 처리를 한 제품목록 불러오기
	List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 제품목록 페이지갯수 알아오기
	int getTotalpage(HashMap<String, String> paraMap) throws SQLException;

	
	
	
}
