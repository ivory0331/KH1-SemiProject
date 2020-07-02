package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class TelVerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//사용자가 가져온 인증코드 
		String telCertificationCode = request.getParameter("telCertificationCode");
		
		//세션 저장된 인증코드 
		HttpSession session = request.getSession();
		String certificationCode = (String)session.getAttribute("certificationCode");
		
		String message = "";
	 	String loc = "";
	 	
	 	if( certificationCode.equals(telCertificationCode) ) {// 세션저장코드 == 사용자인증코드 확인  
	 		message = "인증성공 되었습니다.";
	 		loc = request.getContextPath()+"/member/register.do";
	 	}
	 	else {
	 		message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요";
	 		loc = request.getContextPath()+"/member/register.do";
	 	}
		
	 	request.setAttribute("message", message);
	 	request.setAttribute("loc", loc);
	 	
	 	super.setViewPage("/WEB-INF/msg.jsp");
	 	
	 	// !!! 중요 !!! //
	 	// 세션에 저장된 인증코드 삭제하기 !!!!  
	 	session.removeAttribute("certificationCode"); //PwdFindAcion.java에 저장된 특정값만 없애자
		
	}

}
