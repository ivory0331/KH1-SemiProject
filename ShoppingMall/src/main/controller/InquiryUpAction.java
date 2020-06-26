package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.ProductInquiryVO;
import member.model.MemberVO;

public class InquiryUpAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {
			String member_num = request.getParameter("member_num");
			if(loginuser.getMember_num() != Integer.parseInt(member_num)) {
				String message = "정상적인 접속방법이 아닙니다.";
				String loc = "javascript:history.back()";
				request.setAttribute("messge", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			String inquiry_num = request.getParameter("inquiry_num");
			InterIndexDAO dao = new IndexDAO();
			ProductInquiryVO pivo = dao.inquiryOneSelect(inquiry_num);
			String content = pivo.getContent();
			
			pivo.setContent(content);
			
			request.setAttribute("pivo", pivo);
			super.setViewPage("/WEB-INF/main/productQupdate.jsp");
		}
		else {
			
		}
		
	}

}
