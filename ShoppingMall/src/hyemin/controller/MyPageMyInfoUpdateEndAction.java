package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterMemberDAO;
import hyemin.model.MemberDAO;
import member.model.MemberVO;

public class MyPageMyInfoUpdateEndAction extends AbstractController {

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
			// 개인정보 수정 페이지에서 입력받은 값들 각각 변수에 대입
			String member_num = request.getParameter("member_num");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String mobile = request.getParameter("mobile");
			String gender = request.getParameter("gender");
			String birthyear = request.getParameter("birthyear");
			String birthmonth = request.getParameter("birthmonth");
			String birthday = request.getParameter("birthday");
			
			MemberVO membervo = new MemberVO();
			membervo.setMember_num(Integer.parseInt(member_num));
			membervo.setUserid(userid);			
			membervo.setPwd(pwd);
			membervo.setName(name);
			membervo.setEmail(email);
			membervo.setMobile(mobile);
			membervo.setGender(gender);
			membervo.setBirthday(birthyear+birthmonth+birthday);
			
			InterMemberDAO memberdao = new MemberDAO();
			
			// 회원의 정보 수정
			int n = memberdao.updateMember(membervo);
						
			String message = "";
			String loc = "";
			
			if(n == 1) { // 회원의 정보가 정상적으로 수정되었을 경우
				message = "회원정보가 수정되었습니다.";
				
				// session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다.
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				loginuser.setUserid(userid);
				loginuser.setPwd(pwd);
				loginuser.setName(name);
				loginuser.setEmail(email);
				loginuser.setMobile(mobile);
				loginuser.setGender(gender);
				loginuser.setBirthday(birthday);
				
				session.setAttribute("loginuser", loginuser);
				
				loc = request.getContextPath()+"/member/myPageMyInfoUpdatePW.do";
			}
			else { // 회원의 정보가 정상적으로 수정되지 않았을 경우
				message = "회원정보 수정에 실패했습니다.";
				loc = "javascript:history.back()";
			}
	  
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
