package hyemin.model;

import java.sql.SQLException;
import java.util.List;

import main.model.OrderHistoryVO;
import main.model.OrderVO;

public interface InterOrderDAO {

	// 페이징처리를 안 한, 특정 회원의 모든 주문내역 보여주기
	List<OrderHistoryVO> selectOneMemberAllOrder(String member_num) throws SQLException;

	// order_num 값을 입력받아서 특정 주문 내역의 상세정보를 알아오기(select)
	OrderVO OrderOneDetail(String order_num) throws SQLException;

	

}
