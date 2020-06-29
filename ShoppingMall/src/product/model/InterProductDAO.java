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

	// 대분류와 소분류 불러오기
	List<ProductVO> subcategoryList(String fk_category_num) throws SQLException ;
	
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

	// 장바구니 테이블에서 특정제품을 장바구니에서 주문량 증감시키기 
	int updateCart(String cartno, String oqty) throws SQLException;

	// 페이징 처리를 한 신상품 목록을 조회하기
	List<ProductVO> selectNewList(HashMap<String, String> paraMap) throws SQLException;

	// 페이징 처리를 한 세일품목 조회하기
	List<ProductVO> selectSale(HashMap<String, String> paraMap) throws SQLException;
	
	// 선택한 옵션에 맞게 상품 리스트 보여주기
	List<ProductVO> selectOption(HashMap<String, String> paraMap) throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
}
