package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			//아이디 찾기 버튼을 클릭했을 경우 
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			InterMemberDAO memberdao = new MemberDAO();
			
			HashMap<String,String> paraMap = new HashMap< >();
			paraMap.put("name", name);
			paraMap.put("email", email);
			
			String userid = memberdao.findUserid(paraMap);
		
			if(userid != null ) {
				//아이디가 존재할 때 (글자몇자수 이상이면 *** sql문 처리) 
				
	            request.setAttribute("userid", userid);
				request.setAttribute("name", name); 
				request.setAttribute("email", email);
	            
				super.setRedirect(false);
	            super.setViewPage("/WEB-INF/login/idFind.jsp");
			
	            return;
				
			}else {
				//아이디가 존재하지 않을 때 
				
				String message = "아이디가 존재하지 않습니다";
	            String loc = "javascript:history.back()";

	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);

	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	            
	            return;
			}
			
						
		}//end of if-------------
		else {			
			super.setViewPage("/WEB-INF/login/idFind.jsp");	
			
		}
		request.setAttribute("method", method); //get or post 가 idFind.jsp로 넘어감 
		
		
	}

}
