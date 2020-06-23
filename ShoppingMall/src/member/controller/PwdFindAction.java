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
		// "GET" OR "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			//비밀번호 찾기 모달창에서 찾기 버튼을 클릭했을 경우 
			
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			InterMemberDAO memberdao = new MemberDAO();
			
			HashMap<String,String> paraMap = new HashMap< >();
			paraMap.put("userid", userid);
			paraMap.put("email", email);
			
			boolean isUserExist = memberdao.isUserExist(paraMap); //있으면 T, 없으면 F
			
			int n = 0; //회원 존재여부를 구분하기 위한 표식.
			
			if(isUserExist) {
				//회원으로 존재하는 경우 
				n = 1;
				
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
					
					//String abc = (String) session.getAttribute(certificationCode);
					//System.out.println("~~ 확인용 abc = "+abc);
					
				}catch(Exception e) {
					e.printStackTrace();
					n = -1;
				}
				
			}// end of if -------
			else {
				//회원으로 존재하지 않는 경우 
				n=0;
				
			}//end of else ----- 
			
			request.setAttribute("n", n);
			request.setAttribute("userid", userid);
			request.setAttribute("email", email);
			
		}//end of if("POST".equalsIgnoreCase(method)) {} ---------
		
		request.setAttribute("method", method); //get
		
		//super.setRedirect(false); 
		super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		
	}

}
