package hyemin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterMemberDAO;
import hyemin.model.InterOrderDAO;
import hyemin.model.MemberDAO;
import hyemin.model.MemberVO;
import hyemin.model.OrderDAO;
import hyemin.model.OrderVO;

public class MyPageOrderHistoryDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String member_num = request.getParameter("member_num");
		
		// == 본인 계정으로 로그인 했을때만 조회가 가능하도록 한다. ==
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser == null) {
				
				String message = "먼저 로그인 해야 가능합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
			}
			
			else {
				String userid = loginuser.getUserid();
				
				if(!String.valueOf(loginuser.getMember_num()).equals(member_num)) {
					String message = "본인만 접근 가능합니다.";
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
			OrderVO ovo = odao.oneOrderDetail(order_num);
			request.setAttribute("ovo", ovo);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/myPageOrderHistory.jsp");
		}

}


