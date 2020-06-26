package service.model;

<<<<<<< HEAD
public interface InterServiceDAO {

=======
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import main.model.NoticeVO;

public interface InterServiceDAO {

	// 공지사항 테이블 조회
	List<NoticeVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException;

	// 공지사항 총 게시글 수 조회
	int getTotalPage(HashMap<String, String> paraMap) throws SQLException;

>>>>>>> 7071bca5fc7ada42f6267a1c97b9b4b2490bd4e7
}
