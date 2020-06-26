package hyemin.model;

import java.sql.SQLException;

import member.model.MemberVO;

public interface InterMemberDAO {

	// 특정 회원의 정보 수정하기
	int updateMember(MemberVO membervo) throws SQLException;

}
