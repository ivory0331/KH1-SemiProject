package service.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.OneInquiryVO;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import my.util.MyUtil;

public class ServiceCenterMyQboardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		String method = request.getMethod();
		//로그인 했는지 확인 
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			
			request.setAttribute("message","1:1문의는 로그인 후 이용가능합니다");
			request.setAttribute("loc", request.getContextPath()+"/member/login.do");
			
			super.setViewPage("/WEB-INF/msg.jsp");
			//System.out.println("파일명 : "+ctx 확인값);
		}
		else {
			if(!"POST".equalsIgnoreCase(method)) {
				 
				//super.setViewPage("개인정보 수정하기 페이지로 이동(비밀번호 클릭하고 들어올 수 있게");
				super.setViewPage("/WEB-INF/service/serviceCenterMyQboardWrite.jsp");
				return;
			}
			else {
				String fk_category_num = request.getParameter("fk_category_num");
				String subject = request.getParameter("subject");
				String fk_order_num = request.getParameter("fk_order_num");
				String emailFlag = request.getParameter("emailFlag");
				String smsFlag = request.getParameter("smsFlag");
				String content = request.getParameter("content");
				
				//session에 저장된 로긴유저 가져오기 
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				content = content.replaceAll("<", "&lt;");
		        content = content.replaceAll(">", "&gt;");
		        content = content.replaceAll("\r\n", "<br/>");
		        content = content.replaceAll("&","&amp;");
		        content = content.replaceAll("\"","&quot");
				
		        if(emailFlag==null) emailFlag="0"; //체크박스는 null로 넘어옴
		        if(smsFlag==null) smsFlag="0";
		        if(fk_order_num=="") fk_order_num="0"; //text타입 
		        if(fk_category_num=="") fk_category_num="0";
		       
		        System.out.println("ServiceCenterMyQboardWriteAction null값 확인"+emailFlag+smsFlag+fk_order_num+fk_category_num);
		        
				OneInquiryVO oneInquiryVO = new OneInquiryVO();
				oneInquiryVO.setFk_category_num(Integer.parseInt(fk_category_num));
				oneInquiryVO.setSubject(subject);
				oneInquiryVO.setFk_order_num(Integer.parseInt(fk_order_num));
				oneInquiryVO.setEmailFlag(emailFlag);
				oneInquiryVO.setSmsFlag(smsFlag);
				oneInquiryVO.setContent(content);
				oneInquiryVO.setFk_member_num(loginuser.getMember_num());
				
				InterMemberDAO mbrdao = new MemberDAO();
				int n = mbrdao.serviceCenterMyQboardWrite(oneInquiryVO);
				
				
				System.out.println("글쓰기 등록 성공 n " + n);
				
				if(n==1) { //글쓰기 등록성공! 
					
					request.setAttribute("message","글이 등록 되었습니다! ");
					request.setAttribute("loc", request.getContextPath()+"/service/MyQue.do");
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
				else { //글쓰기 등록 실패!
					request.setAttribute("message","글쓰기 등록이 실패되었습니다");
					//request.setAttribute("loc", "javascript:history.back()");
					request.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
					
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
			}//end of else ---
		}
		
	}

}
