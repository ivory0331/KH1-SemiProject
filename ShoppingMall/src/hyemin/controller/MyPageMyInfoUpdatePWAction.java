package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class MyPageMyInfoUpdatePWAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();	// "GET" or "POST"
		
		if(!"POST".equalsIgnoreCase(method)) {
			// POST 방식으로 넘어온 것이 아니라면
			
			request.setAttribute("message", "비정상적인 경로로 들어왔습니다.");
			request.setAttribute("loc", "javascript:history.back()");
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;	// execute(HttpServletRequest request, HttpServletResponse response) 메소드 종료
		}		
		
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			request.setAttribute("message", "로그인하셔야 본 서비스를 이용하실 수 있습니다.");
			request.setAttribute("loc", "javascript:history.back()"); 
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
		
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			String passwd = request.getParameter("passwd");
			
			if(loginuser.getPwd() != passwd) {				
				request.setAttribute("message", "비밀번호를 정확하게 입력해 주세요.");
				request.setAttribute("loc", "javascript:history.back()"); 
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			else {
			//	super.setRedirect(false);	
				super.setViewPage("/WEB-INF/member/myPageMyInfoUpdate.jsp");
			}
			
		}	
		
	}

}





















