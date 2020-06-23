package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterOrderDAO;
import hyemin.model.OrderDAO;
import main.model.OrderVO;
import member.model.MemberVO;


public class MyPageOrderHistoryDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 본인 아이디로 로그인 했을때만 조회가 가능하도록 한다. ==
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null) {
			
			String message = "로그인하셔야 본 서비스를 이용하실 수 있습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		else {
			String userid = loginuser.getUserid();
			
			if(!String.valueOf(loginuser.getUserid()).equals(userid)) {
				String message = "다른 사용자의 정보는 조회하실 수 없습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////
		String order_num = request.getParameter("order_num");
		InterOrderDAO odao = new OrderDAO();
		OrderVO ovo = odao.OrderOneDetail(order_num);
		request.setAttribute("ovo", ovo);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/myPageOrderHistoryDetail.jsp");
	}

}


