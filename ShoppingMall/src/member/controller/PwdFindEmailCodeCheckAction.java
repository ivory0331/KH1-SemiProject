package member.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class PwdFindEmailCodeCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String email = request.getParameter("email");
		System.out.println("email:"+email);
		//== 인증키를 랜덤하게 생성하도록 한다. 
		Random rnd = new Random();
		
		String certificationCode = "";
		// certificationCode ==> "swfet0933651"
		
		char randchar = ' ';
		for(int i=0; i<5; i++) {
		/*
		    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
		    int rndnum = rnd.nextInt(max - min + 1) + min;
		       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
		 */
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			certificationCode += randchar;
		}
		
		int randnum = 0;
		for(int i=0; i<7; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			certificationCode += randnum;
		}
		
		System.out.println("~~~~ 확인용 certificationCode => " + certificationCode);
		//~~~~ 확인용 certificationCode => iogdq2204326
		
		//랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 이메일로 전송 
		GoogleMail mail = new GoogleMail();
		
		//와스메모리에 저장된 세션을 다시 가져오자 ... 
		HttpSession session = request.getSession();
		
		try {
			mail.sendmail(email, certificationCode ); // mail.sendmail("받는이","랜덤코드")
			session.setAttribute("certificationCode", certificationCode); // 웹브라우저가 쓸수있는 공간에 저장시켜두기 
			//자바에서 발급한 인증코드를 세션에 저장!! VerifyCertifivation.java
			
			String abc = (String) session.getAttribute("certificationCode");
			System.out.println("~~ 확인용 abc = "+abc);
			
		}catch(Exception e) {
			System.out.println("에러발생");
			e.printStackTrace();
			
		}
		// request.setAttribute("randchar", randchar); 
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/pwdFindEmailCodeCheck.jsp");
		
		
	}
	
	

}
