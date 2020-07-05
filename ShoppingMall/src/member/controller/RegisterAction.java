package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;


public class RegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/register.jsp");
			 
		}
		else {
			
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String email = request.getParameter("email");
			String mobile = request.getParameter("mobile");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String gender = request.getParameter("gender");
			String birthyear = request.getParameter("birthyear");
			String birthmonth = request.getParameter("birthmonth");
			String birthday = request.getParameter("birthday");
			
			MemberVO membervo = new MemberVO();
			
			membervo.setName(name);
			membervo.setUserid(userid);
			membervo.setPwd(pwd);
			membervo.setEmail(email);
			membervo.setMobile(mobile);
			membervo.setPostcode(postcode);
			membervo.setAddress(address);
			membervo.setDetailAddress(detailAddress);
			membervo.setGender(gender);
			membervo.setBirthday(birthyear+birthmonth+birthday);
			
			InterMemberDAO memberdao = new MemberDAO();
			
			int n = memberdao.registerMember(membervo); 
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				message = "회원가입 성공";
				loc = request.getContextPath()+"/index.do";
				
			}
			else {
				message = "회원가입 실패";
				loc= "javascript:history.back()"; //자바스크립트를 이용한 이전 페이지로 이동하는 것.
			}
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}
}
