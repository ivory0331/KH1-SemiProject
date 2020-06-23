package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class LoginAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String method = request.getMethod();
      if("get".equalsIgnoreCase(method)) {
    	 super.setRedirect(false);
         super.setViewPage("/WEB-INF/member/login.jsp");
      }
      else {
         // == POST 방식으로 넘어온 것
         String userid = request.getParameter("userid");
         String pwd = request.getParameter("pwd");

         HashMap<String, String> paraMap = new HashMap<String, String>();
         paraMap.put("userid", userid);
         paraMap.put("pwd", pwd);

         InterMemberDAO memberdao = new MemberDAO();

         MemberVO loginuser = memberdao.selectOneMember(paraMap);
         // loginuser == 로그인 되어진 유저

         if (loginuser != null && loginuser.isIdleStatus() == false) {
            // 로그인 성공시

            HttpSession session = request.getSession();
            session.setAttribute("loginuser", loginuser);
            String goBackURL = request.getContextPath() + "/index.do";
            
            if (loginuser.isRequirePwdChange() == true) {
               String message = "비밀번호를 변경하신지 3개월이 지났습니다. 암호를 변경하세요!";
               String loc = request.getContextPath() + "/index.do";
               // 원래는 사용자정보 변경페이지로 이동하도록 loc 를 정해주어야 한다. ==> 사용자 정보페이지 이동 경로설정!!

               request.setAttribute("message", message);
               request.setAttribute("loc", loc);

               super.setRedirect(false);
               super.setViewPage("/WEB-INF/msg.jsp");

               return;
            }
            
            if(session.getAttribute("goBackURL")==null) {
            	goBackURL = (String) session.getAttribute("goBackURL");
            	session.removeAttribute("goBackURL");
            }
            

            // 시작페이지로 이동
            super.setRedirect(true);
            super.setViewPage(goBackURL);

            return;
         }

         else if (loginuser != null && loginuser.isIdleStatus() == true) {
            // 로그인을 한지 1년이 지나서 휴면 상태에 빠진 경우

            String message = "로그인을 한지 1년이 지나서 휴면상태로 전환되었습니다. 관리자에게 문의바랍니다.";
            String loc = request.getContextPath() + "/index.do";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");

            // alert 창에서 "확인"을 클릭해주면 휴면계정인 상태를 다시 정상적으로 사용되어지게끔 해주겠다. //
            HttpSession session = request.getSession();
            session.setAttribute("loginuser", loginuser);

            memberdao.expireIdle(loginuser.getMember_num());
            // 휴면상태인 사용자 계정을 휴면이 아닌것으로 해주어야 한다.
            // 즉, lastlogindate 컬럼의 값을 sysdate로 update 해준다.

            return;
         }

         else {
            // 로그인 실패시
            String message = "로그인에 실패하였습니다.";
            String loc = "javascript:history.back()";

            request.setAttribute("message", message);
            request.setAttribute("loc", loc);

            super.setRedirect(false);
            super.setViewPage("/WEB-INF/msg.jsp");
         }
      
      }
      
      
   }

}
