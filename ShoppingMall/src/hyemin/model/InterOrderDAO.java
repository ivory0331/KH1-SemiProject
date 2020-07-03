package hyemin.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import main.model.OrderHistoryDetailVO;
import main.model.OrderHistoryVO;
import main.model.OrderVO;

public interface InterOrderDAO {

	// 페이징처리를 안 한, 특정 회원의 모든 주문내역 보여주기
	List<OrderHistoryVO> selectOneMemberAllOrder(int member_num) throws SQLException;

	// order_num 값을 입력받아서 특정 주문 내역의 상품정보를 알아오기(select)
	List<OrderHistoryDetailVO> OneOrderProductsDetail(String order_num) throws SQLException;

	// order_num 값을 입력받아서 특정 주문 내역의 상세정보를 알아오기(select)
	OrderVO OneOrderInfoDetail(String order_num) throws SQLException;

	// 페이징처리를 한, 특정 회원의 모든 주문내역 보여주기
	List<OrderHistoryVO> selectPagingOneMemberAllOrder(HashMap<String, String> paraMap, int member_num) throws SQLException;

	// 페이징처리를 위한 특정 회원의 모든 주문내역에 대한 총페이지갯수 알아오기(select)
	int getPossibleReviewTotalPage(HashMap<String, String> paraMap, int member_num) throws SQLException;

	

}
