package hyemin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterOrderDAO;
import hyemin.model.OrderDAO;
import main.model.OrderHistoryVO;
import member.model.MemberVO;


public class MyPageOrderHistoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String member_num = request.getParameter("member_num");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	
		if( !super.checkLogin(request) ) {
			// 로그인을 하지 않았을 경우
			
			String message = "로그인하셔야 본 서비스를 이용하실 수 있습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else if ( super.checkLogin(request) && !String.valueOf(loginuser.getMember_num()).equals(member_num) ) {
			// 로그인은 했으나 다른 사용자의 회원번호(member_num)를 사용하려는 경우
			
			String message = "다른 사용자의 정보는 조회하실 수 없습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
	
		else {
			// 로그인 했고 자신의 회원번호(member_num)를 사용하려는 경우
			
			InterOrderDAO orderdao = new OrderDAO();
			
			// *** 페이징처리를 안 한, 특정 회원의 모든 주문내역 보여주기 *** //
			List<OrderHistoryVO> orderHistoryList = orderdao.selectOneMemberAllOrder(member_num);
		
			request.setAttribute("orderHistoryList", orderHistoryList);
			
		//	super.setRedirect(false);	
			super.setViewPage("/WEB-INF/member/myPageOrderHistory.jsp");
		}

	}

}
