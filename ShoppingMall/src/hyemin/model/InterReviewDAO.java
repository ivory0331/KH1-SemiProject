package hyemin.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.model.OrderProductVO;
import main.model.ReviewVO;

public interface InterReviewDAO {

	// 페이징처리를 안 한, 특정 회원의 모든 작성가능 후기내역 보여주기
	List<OrderProductVO> selectPossibleReview(int member_num) throws SQLException;
	
	// 페이징처리를 안 한, 특정 회원의 모든 작성완료 후기내역 보여주기
	List<ReviewVO> selectCompleteReview(int member_num) throws SQLException;

	// 특정 회원의 작성가능 후기 내역 개수 알아보기
	int selectPossibleReviewCount(int member_num) throws SQLException;

	// 특정 회원의 작성완료 후기 내역 개수 알아보기
	int selectCompleteReviewCount(int member_num) throws SQLException;

	// 특정 작성완료 후기 삭제하기
	int deleteReview(String review_num) throws SQLException;

	// 후기 작성하기
	int writeReview(Map<String, String> paraMap) throws SQLException;

	
	
	

}
