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
}
