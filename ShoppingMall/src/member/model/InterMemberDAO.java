package member.model;

import java.sql.SQLException;

public interface InterMemberDAO {
	
	// ID중복 검사 (userid가 중복이 없어서 사용가능하다라면 true, userid가 이미 존재하여 사용 불가능하면 false 를 리턴)
		boolean idDuplicateCheck(String userid) throws SQLException;

		// 이메일 중복 검사
		boolean emailDuplicateCheck(String email) throws SQLException;


}
