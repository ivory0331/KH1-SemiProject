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

	// 대분류 카테고리 불러오기 abstract
	List<HashMap<String, String>> getCategoryList() throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	
	
	//////////////////////////////// 매니저 진하
	
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

	// 소분류 구하기
	List<HashMap<String, String>> getSubCategoryList(String fk_category_num) throws SQLException;

	// 페이징 처리를 한 제품목록 불러오기
	List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 제품목록 페이지갯수 알아오기
	int getTotalpage(HashMap<String, String> paraMap) throws SQLException;

	// 로그인한 사용자의 장바구니 목록을 조회하기
	List<CartVO> selectProductCart(int member_num) throws SQLException;

	// 로그인한 사용자의 장바구니에 담긴 주문총액합계
	HashMap<String, String> selectSumCartPricePoint(int member_num) throws SQLException;

	// 장바구니 테이블에서 특정제품을 장바구니에서 비우기  
	int delCart(String cartno) throws SQLException;

	
	
	
}
