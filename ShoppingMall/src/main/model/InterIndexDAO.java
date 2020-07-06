package main.model;

import java.sql.SQLException; 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;
import product.model.CartVO;

public interface InterIndexDAO {
	// Index.jsp의 slide영역에 나올 상품 리스트 출력
	List<ProductVO> listCall(Map<String,String>paraMap) throws SQLException;

	// Index.jsp에 출력된 리스트 상품의 상세페이지 값 출력
	ProductVO productDetail(String idx) throws SQLException;

	// 모든 상품번호를 조회
	List<String> product_numFind() throws SQLException;

	// 특정 상품의 후기 조회
	List<ReviewVO> reviewCall(Map<String, Integer> paraMap) throws SQLException;

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

	// 최근 배송지역 유무 조회
	Map<String, String> orderHistoryFind(int member_num)throws SQLException;

	// 주문서 페이지의 값 DB 저장(결제) 및 장바구니 비우기
	int order(MemberVO loginuser, Map<String, String> delivery, List<CartVO> cartList)throws SQLException;

	// 상품 검색 결과 조회
	List<ProductVO> selectPagingProduct(HashMap<String, String> paraMap)throws SQLException;

	// 상품 검색 결과 행의 갯수 조회
	int getTotalpage(HashMap<String, String> paraMap)throws SQLException;

	// 상품문의 삭제 시 같이 삭제될 업로드 이미지 조회
	List<String> DelImgFind(String inquiry_num)throws SQLException;

	// 상품문의 수정
	int productQupdate(Map<String, String> paraMap)throws SQLException;

	// 상품문의 수정 시 기존에 있던 이미지 조회 및 삭제
	List<String> inquiryImgDel(String inquiry_num, String[] fileNameArr)throws SQLException;

	// 해당 상품의 리뷰 갯수 조회
	int getReviewtotalPage(Map<String, Integer> paraMap)throws SQLException;

	// 리뷰 조회수 증가
	int reviewHitUp(String review_num)throws SQLException;

	// 특정 리뷰 삭제
	int reviewDel(String review_num)throws SQLException;

	// 모든 1:1문의 조회 -관리자-
	List<OneInquiryVO> allOneInquirySelect(HashMap<String, String> paraMap)throws SQLException;

	// 1:1문의 카테고리 조회 -관리자-
	List<Map<String, String>> oneInquiryCategroySelect()throws SQLException;

	// 조회한 결과물의 총 수 조회 -관리자-
	int getTotalPageQuiry(HashMap<String, String> paraMap)throws SQLException;

	// 모든 상품문의 조회 -관리자-
	List<ProductInquiryVO> allProductInquirySelect(HashMap<String, String> paraMap)throws SQLException;

	// 1차분류 항목 조회
	List<Map<String, String>> productInquiryCategroySelect()throws SQLException;

	// 2차분류 항목 조회
	List<Map<String, String>> productInquirySubcategroySelect(String searchCategory)throws SQLException;

	// 특정 1:1문의 조회
	OneInquiryVO oneInquirySelect(String quiry_num)throws SQLException;

	// 특정 문의 글에 답변 작성
	int answerWrite(Map<String, String> paraMap)throws SQLException;

	// 날짜별 매출 조회
	List<Map<String, String>> allSalesSelect(String type)throws SQLException;

	// 모든 회원의 주문 조회
	List<OrderVO> selectOrder(HashMap<String, String> paraMap)throws SQLException;

	// 배송상태 조회
	List<Map<String, String>> getOrderStateList()throws SQLException;

	// 주문관리 주문테이블 행의 총 갯수
	int getTotalPageOrder(HashMap<String, String> paraMap)throws SQLException;

	// 특정 주문정보의 배송상태 변경
	int orderStateChane(Map<String, String> paraMap)throws SQLException;

	// 상품문의 테이블 게시글 수 조회
	int getTotalPageProductInquiry(HashMap<String, String> paraMap)throws SQLException;


	

	

	
}
