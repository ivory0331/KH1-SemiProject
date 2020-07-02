package manager.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import main.model.OrderHistoryVO;
import member.model.MemberVO;

public interface InterMemberDAO {
	
	//////////////////매니저 진하
	// 전체 회원 조회
	List<MemberVO> selectAllMember() throws SQLException;
	
	
	// 페이징 처리
	List<MemberVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException;
	
	
	// 페이지 그룹
	int getTotalPage(HashMap<String,String> paraMap) throws SQLException;
	
	
	// 회원 삭제
	int memberDelete(String member_num) throws SQLException;

	// 회원 상세 보기
	MemberVO detailMember(String member_num) throws SQLException;

	// 회원 주문 내역 전부 보기
	List<OrderHistoryVO> selectOneMemberAllOrder(String member_num) throws SQLException; 	


}
