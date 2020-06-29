package member.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class PwdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		HttpSession session = request.getSession();
		// "GET" OR "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			//비밀번호 찾기 모달창에서 찾기 버튼을 클릭했을 경우 
			
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			InterMemberDAO memberdao = new MemberDAO();
			
			HashMap<String,String> paraMap = new HashMap< >();
			paraMap.put("name", name);
			paraMap.put("userid", userid);
			paraMap.put("email", email);
			
			boolean isUserExist = memberdao.isUserExist(paraMap); //있으면 T, 없으면 F
			
			int n = 0; //회원 존재여부를 구분하기 위한 표식.
			
			if(isUserExist) {
				//회원으로 존재하는 경우 
				n = 1;
				session.setAttribute("userid", userid);
				
			}// end of if -------
			else {
				//회원으로 존재하지 않는 경우 				
				String message = "회원 정보가 없습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
	            request.setAttribute("loc", loc);

				n=0;
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
											
				
			}//end of else ----- 
			
			request.setAttribute("n", n);
			request.setAttribute("name", name);
			request.setAttribute("userid", userid);
			
			request.setAttribute("email", email);
			
			super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		}//end of if("POST".equalsIgnoreCase(method)) {} ---------
		else {
			//super.setRedirect(false); 
			super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		}
		request.setAttribute("method", method); 
	}

}
