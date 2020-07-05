package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		//  "GET" or "POST" 
		
		String userid = request.getParameter("userid");
		int n =0;
		if("POST".equalsIgnoreCase(method)) {
			String pwd = request.getParameter("pwd");
			
			InterMemberDAO memberdao = new MemberDAO();
			n = memberdao.pwdUpdate(pwd, userid);
			System.out.println("n=>"+n);
			System.out.println("userid"+userid);
			request.setAttribute("n", n);
			if(n==1) {
				
				String message = "비밀번호가 변경되었습니다";
				String loc = request.getContextPath()+"/member/login.do";

		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);

		        			
			}else {
				String message = "비밀번호가 변경이 실패되었습니다";
				String loc = request.getContextPath()+"/member/login.do";

		        request.setAttribute("message", message);
		        request.setAttribute("loc", loc);

		        			
			}
			
			
			request.setAttribute("userid", userid);
			
			 super.setRedirect(false);
		     super.setViewPage("/WEB-INF/msg.jsp");	
		     return;
		}
		else {
			super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");
		}
		
				
				
	}

}
