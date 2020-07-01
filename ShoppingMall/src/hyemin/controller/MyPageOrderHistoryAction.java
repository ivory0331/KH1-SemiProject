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
		
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			// 로그인을 하지 않았을 경우
			
			String loc = request.getContextPath()+"/member/login.do";
			
			request.setAttribute("message", "로그인하셔야 본 서비스를 이용하실 수 있습니다.");
			request.setAttribute("loc", loc);
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			// 로그인 했고 자신의 회원번호(member_num)를 사용하려는 경우
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			InterOrderDAO orderdao = new OrderDAO();
			
			// *** 페이징처리를 안 한, 특정 회원의 모든 주문내역 보여주기 *** //
			List<OrderHistoryVO> orderHistoryList = orderdao.selectOneMemberAllOrder(loginuser.getMember_num());
		
			request.setAttribute("orderHistoryList", orderHistoryList);
			
		//	super.setRedirect(false);	
			super.setViewPage("/WEB-INF/member/myPageOrderHistory.jsp");
		}

	}

}
