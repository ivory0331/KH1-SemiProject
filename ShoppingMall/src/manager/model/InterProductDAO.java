package manager.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterProductDAO {
	
	// 전체 상품 조회
	List<ProductVO> selectAllProduct() throws SQLException;

	// 검색처리
	List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap) throws SQLException;

	// 전체페이지 설정
	int getTotalPage(HashMap<String, String> paraMap) throws SQLException;

	// 상품 삭제
	int productDelete(String product_num) throws SQLException;

	// 상품명 중복 확인
	boolean productNameDuplicateCheck(String productName) throws SQLException;



}
