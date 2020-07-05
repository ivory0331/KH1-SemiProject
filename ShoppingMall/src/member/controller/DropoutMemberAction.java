package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import my.util.MyUtil;

public class DropoutMemberAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		//로그인 했는지 확인 
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			
			request.setAttribute("message","회원탈퇴를 하기 위해선 로그인부터 하세요");
			request.setAttribute("loc", request.getContextPath()+"/index.do");
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			if(!"POST".equalsIgnoreCase(method)) {
				//비정상적인 경로로 들어왔음을 알리기 
				//super.setViewPage("개인정보 수정하기 페이지로 이동(비밀번호 클릭하고 들어올 수 있게");
				super.setViewPage("/WEB-INF/member/dropoutMember.jsp");
				return;
			}
			else {
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				InterMemberDAO mbrvo = new MemberDAO();
				int n = mbrvo.dropoutMember(loginuser.getUserid());
				System.out.println("회원 정보 n " + n);
				if(n==1) { //회원삭제 완료 
					session.removeAttribute("loginuser");
					request.setAttribute("message","회원탈퇴가 되었습니다. 다음에 또 뵙겠습니다 :) ");
					request.setAttribute("loc", request.getContextPath()+"/index.do");
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
				else { //회원삭제 실패 
					request.setAttribute("message","회원탈퇴가 실패 되었습니다");
					request.setAttribute("loc", "javascript:history.back()");
					//request.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
			}//end of else ---
		}
		
		
	}

}