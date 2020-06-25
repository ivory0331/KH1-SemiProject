package main.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterIndexDAO {
	// Index.jsp의 slide영역에 나올 상품 리스트 출력
	List<ProductVO> listCall(Map<String,String>paraMap) throws SQLException;

	// Index.jsp에 출력된 리스트 상품의 상세페이지 값 출력
	ProductVO productDetail(String idx) throws SQLException;

	// 모든 상품번호를 조회
	List<String> product_numFind() throws SQLException;

	// 특정 상품의 후기 조회
	List<ReviewVO> reviewCall(String product_num) throws SQLException;

	// 특정 상품의 상품문의 조회
	List<ProductInquiryVO> productQCall(Map<String, Integer> paraMap) throws SQLException;

	// 상품의 대분류, 소분류 카테고리 정보 조회
	List<Map<String, String>> categoryCall() throws SQLException;

	// 상품 선택했을 때 기존의 장바구니에 있는 상품을 조회
	boolean basketSelect(Map<String, String> orderMap) throws SQLException;

	// 선택한 상품 장바구니에 추가
	int basketInsert(Map<String, String> orderMap) throws SQLException;

	// 로그인하면 기존에 남은 장바구니의 상품 수 조회
	int basketCnt(int i) throws SQLException;

	// 상품문의 글작성 (파일 업로드)
	int productQwrite(Map<String, String> paraMap)throws SQLException;

	// 자신이 작성한 상품문의 글 삭제
	int inquiryDel(String inquiry_num)throws SQLException;

	// 특정 상품문의 글 조회
	ProductInquiryVO inquiryOneSelect(String inquiry_num)throws SQLException;

	// answer컬럼이 있는 테이블에서 answer컬럼이 null이 아닌 행의 갯수를 조회
	int answerCall(Map<String, Integer> paraMap)throws SQLException;

	// answer컬럼이 있는 테이블의 총 행의 갯수(질문 글 + 답변 글)
	int totalPage(Map<String, Integer> paraMap)throws SQLException;

	// 해당 상품이 로그인 한 회원의 후기작성이 가능한 상품인지 조회
	OrderProductVO productReviewFind(Map<String, String> paraMap)throws SQLException;

	

	

	
}
