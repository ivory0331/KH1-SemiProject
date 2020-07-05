package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;

public class TelVerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//사용자가 가져온 인증코드 
		//String telCertificationCode = request.getParameter("telCertificationCode");
		String telCertificationCode = request.getParameter("tel_confirm");
		
		//세션 저장된 인증코드 
		HttpSession session = request.getSession();
		String certificationCode = (String)session.getAttribute("certificationCode");
		//smsSendAction에 세션에 저장된 certificationCode가져와서 비교 
			 	
	 	int n = 0; //인증 성공여부 구분
	 	if( certificationCode.equals(telCertificationCode) ) {// 세션저장코드 == 사용자인증코드 확인  
	 		n = 1;
	 	}
	 	else {	 		
	 		n = 0;
	 	}
		
	 	JSONObject jsonObj = new JSONObject();
	    jsonObj.put("n", n);			
	      
	    String json = jsonObj.toString();		
	    request.setAttribute("json", json);
	    
	    super.setViewPage("/WEB-INF/jsonview.jsp");
	   
	 	
	 	// !!! 중요 !!! //
	 	// 세션에 저장된 인증코드 삭제하기 !!!!  
	 	session.removeAttribute("certificationCode"); //PwdFindAcion.java에 저장된 특정값만 없애자
		
	}

}
