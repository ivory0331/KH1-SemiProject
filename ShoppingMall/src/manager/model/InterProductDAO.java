package manager.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import product.model.ProductVO;

public interface InterProductDAO {
	
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
	boolean productNameDuplicateCheck(String productName, String productNum) throws SQLException;
	
	// 대분류 카테고리 불러오기 abstract
	List<HashMap<String, String>> getCategoryList() throws SQLException;

	// 소분류 구하기
	List<HashMap<String, String>> getSubCategoryList(String fk_category_num) throws SQLException;

	// 제품 등록을 위한 제품 번호 채번
	int getPnumOfProduct() throws SQLException;

	// 제품 신상 등록
	int productInsert(ProductVO pvo) throws SQLException;

	// 제품 신상 상세이미지 등록
	int productImageInsert(int product_num, String detail_img) throws SQLException;

	// 제품 상세 정보 보기
	ProductVO detailProduct(String product_num) throws SQLException;

	// 제품 상세 정보 보기 - 상세 이미지
	List<String> detailProductImg(String product_num) throws SQLException;

	// 제품 수정
	int productUpdate(ProductVO pvo) throws SQLException;

	// 제품 수정 상세이미지 교체
	int productImageReplace(String detail_img, String old_name) throws SQLException;

	// 제품 수정 상세이미지 업로드
	int productImageUpdate(int product_num, String detail_img) throws SQLException;

	// 제품 수정 상세이미지 삭제
	int productImageDelete(String old_name) throws SQLException;

	

}
