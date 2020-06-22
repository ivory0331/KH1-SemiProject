package hyemin.model;

import java.sql.SQLException;

public interface InterReviewDAO {
	
	// 상품 후기 작성하기
	int writeReview(ReviewVO reviewvo) throws SQLException;

}
