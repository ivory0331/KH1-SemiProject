package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.MemberVO;


public class MyPageOrderHistoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	/*	
		String member_num = request.getParameter("member_num");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( !super.checkLogin(request) ) {
			// 로그인을 하지 않았을 경우
			
			String message = "로그인을 하시기 바랍니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else if ( super.checkLogin(request) && !String.valueOf(loginuser.getMember_num()).equals(member_num) ) {
			// 로그인은 했으나 다른 사용자의 회원번호(member_num)를 사용하려는 경우
			
			String message = "다른 사용자의 주문내역은 조회 불가합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
	*/			
	//	else {
			// 로그인 했고 자신의 회원번호(idx)를 사용하려는 경우
			
		 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/myPageOrderHistory.jsp");
	//	}

	}

}
