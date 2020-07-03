package hyemin.model;

import java.sql.SQLException;
import java.util.HashMap;
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
	
	// 후기 작성하기
	int writeReview(Map<String, String> paraMap) throws SQLException;

	// 특정 작성완료 후기 첨부이미지명 알아오기
	String selectReviewFileName(String review_num) throws SQLException;
	
	// 특정 작성완료 후기 삭제하기
	int deleteReview(String review_num) throws SQLException;

	// 수정 가능한 작성완료 후기인지 알아보기
	ReviewVO ReviewFind(String review_num) throws SQLException;

	// 특정 작성완료 후기 수정하기
	int updateReview(Map<String, String> paraMap) throws SQLException;

	// 후기 이미지 테이블에 기존에 있던 사진 조회 및 삭제
	String ReviewImgDel(String review_num, String oldFileName) throws SQLException;

	// 페이징처리를 한, 특정 회원의 모든 작성가능 후기내역 보여주기
	List<OrderProductVO> selectPagingPossibleReview(HashMap<String, String> paraMap, int member_num) throws SQLException;

	// 페이징처리를 위한 특정 회원의 작성가능 후기 내역에 대한 총페이지갯수 알아오기(select)
	int getPossibleReviewTotalPage(HashMap<String, String> paraMap, int member_num) throws SQLException;

	// 페이징처리를 한, 특정 회원의 모든 작성완료 후기내역 보여주기
	List<ReviewVO> selectPagingCompleteReview(HashMap<String, String> paraMap, int member_num) throws SQLException;

	// 페이징처리를 위한 특정 회원의 모든 작성완료 후기내역에 대한 총페이지갯수 알아오기(select)
	int getCompleteReviewTotalPage(HashMap<String, String> paraMap, int member_num) throws SQLException;





	
	
	

}
