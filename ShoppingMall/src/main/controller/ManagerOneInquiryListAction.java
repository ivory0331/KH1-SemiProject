package main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.OneInquiryVO;
import member.model.MemberVO;

public class ManagerOneInquiryListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser== null || loginuser.getStatus()!=2) {
			String message = "관리자가 아닌 사용자는 접속할 수 없습니다.";
			String loc = request.getContextPath()+"/index.do";
			request.setAttribute("message", message);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		InterIndexDAO dao = new IndexDAO();
		List<OneInquiryVO> inquiryList = dao.allOneInquirySelect();
		
	}

}
