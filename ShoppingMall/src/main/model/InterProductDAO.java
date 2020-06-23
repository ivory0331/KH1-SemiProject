package main.model;

import java.sql.SQLException;

public interface InterProductDAO {

	// 특정 상품정보 조회
	ProductVO productInfo(String product_num) throws SQLException;

}
