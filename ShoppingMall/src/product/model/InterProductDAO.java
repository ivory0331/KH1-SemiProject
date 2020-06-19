package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterProductDAO {

	// 제품 목록 불러오기
	List<ProductVO> selectProductList(HashMap<String, String> paraMap) throws SQLException;
	
}
