package manager.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.OneInquiryVO;
import main.model.OrderHistoryVO;
import main.model.ReviewVO;
import manager.model.*;
import member.model.MemberVO;

public class ManagerMemberDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		
		// 1. 로그인 해야 가능		
		if(!super.checkLogin(request)) {
			
			 String message = "로그인 하세요.";
	         String loc = "/ShoppingMall/member/login.do";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	         return;
	         
		}
		
		
		//2. 관리자로 로그인 해야 가능
		else {
	    	 HttpSession session = request.getSession();
	    	 MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	         int status = loginuser.getStatus();
	         
	         if(status!=2) {
	        	String message = "권한이 없습니다.";
	            String loc = "/ShoppingMall/index.do";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	            
	            return;
	         }
	         
	    }
		
		
		String member_num = request.getParameter("member_num");

		InterMemberDAO mdao = new MemberDAO();
		
		// 1. 회원정보
		MemberVO mvo = mdao.detailMember(member_num);		
		request.setAttribute("mvo",mvo);
		
		
		
		
		super.setViewPage("/WEB-INF/manager/managerMemberDetail.jsp");

			
				
	}

}
