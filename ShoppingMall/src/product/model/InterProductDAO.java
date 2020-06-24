package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import product.model.CartVO;

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

	// 로그인한 사용자의 장바구니 목록을 조회하기
	List<CartVO> selectProductCart(int member_num) throws SQLException;

	// 로그인한 사용자의 장바구니에 담긴 주문총액합계
	HashMap<String, String> selectSumCartPricePoint(int member_num) throws SQLException;

	
	
	
}
