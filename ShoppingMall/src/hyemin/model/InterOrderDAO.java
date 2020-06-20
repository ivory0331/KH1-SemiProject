package hyemin.model;

import java.sql.SQLException;
import java.util.List;

public interface InterOrderDAO {

	// 페이징처리를 안 한, 특정 회원의 모든 주문내역 보여주기
	List<OrderVO> selectOneMemberAllOrder(String member_num) throws SQLException;

}
