package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterMemberDAO;
import hyemin.model.MemberDAO;
import member.model.MemberVO;

public class MyPageMyInfoUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// *** POST 방식으로 넘어온 것이 아니라면 *** //
		String method = request.getMethod();

		if(!"POST".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로를 통해 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");	
			
			String passwd = request.getParameter("passwd");
			
			InterMemberDAO mdao = new MemberDAO();
			int pwdCheck = mdao.updatePwdCheck(loginuser.getUserid(), passwd);

			// 입력한 비밀번호가 현재 로그인한 회원의 비밀번호와 동일한 경우
			if(pwdCheck == 1) {
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/myPageMyInfoUpdate.jsp");			
			}
			
			// 입력한 비밀번호가 현재 로그인한 회원의 비밀번호와 다른 경우
			else {
				String message = "비밀번호를 정확하게 입력해 주세요.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}

		}
	}
}

