package hyemin.model;

import java.sql.SQLException;

import member.model.MemberVO;

public interface InterMemberDAO {

	// 개인정보수정 전, 현재 비밀번호 확인하기
	int updatePwdCheck(String userid, String passwd) throws SQLException;
	
	// 특정 회원의 정보 수정하기
	int updateMember(MemberVO membervo) throws SQLException;

}
