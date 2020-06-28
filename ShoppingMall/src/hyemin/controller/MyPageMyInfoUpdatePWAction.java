package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterMemberDAO;
import hyemin.model.MemberDAO;
import member.model.MemberVO;

public class MyPageMyInfoUpdatePWAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			// 로그인을 하지 않았을 경우
			
			request.setAttribute("message", "로그인하셔야 본 서비스를 이용하실 수 있습니다.");
			request.setAttribute("loc", "javascript:history.back()");
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			// 로그인 했을 경우

		//	super.setRedirect(false);	
			super.setViewPage("/WEB-INF/member/myPageMyInfoUpdatePW.jsp");
			
		}	
		
	}

}





















