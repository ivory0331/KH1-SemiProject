package manager.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.model.OneInquiryVO;
import main.model.OrderHistoryVO;
import main.model.ReviewVO;
import member.model.MemberVO;

public interface InterMemberDAO {
	
	// 전체 회원 조회
	List<MemberVO> selectAllMember() throws SQLException;
	
	
	// 페이징 처리
	List<MemberVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException;
	
	
	// 페이지 그룹
	int getTotalPage(HashMap<String,String> paraMap) throws SQLException;
	
	
	// 회원 삭제
	int memberDelete(String member_num) throws SQLException;

	
	// 회원 상세 정보 보기
	MemberVO detailMember(String member_num) throws SQLException;

	
	// 회원 주문 내역
	List<OrderHistoryVO> orderCall(Map<String, Integer> paraMap) throws SQLException; 	
	int getOrdertotalPage(Map<String, Integer> paraMap) throws SQLException;
	
	
	// 회원 후기 내역 
	List<ReviewVO> reviewCall(Map<String, Integer> paraMap) throws SQLException;
	int getReviewtotalPage(Map<String, Integer> paraMap) throws SQLException;

	
	// 회원 일대일 질문 내역 
	List<OneInquiryVO> oneQCall(Map<String, Integer> paraMap) throws SQLException;
	int getOneQtotalPage(Map<String, Integer> paraMap) throws SQLException;






}
