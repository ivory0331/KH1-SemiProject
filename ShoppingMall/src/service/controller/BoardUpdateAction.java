package service.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.NoticeVO;
import member.model.MemberVO;
import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class BoardUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String notice_num = request.getParameter("notice_num");
		String method = request.getMethod();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null && loginuser.getStatus()!=2) {
			String message = "올바른 접속경로가 아닙니다.";
			String loc = request.getContextPath()+"/service/board.do";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		if("get".equalsIgnoreCase(method)) {
			InterServiceDAO dao = new ServiceDAO();
			NoticeVO nvo = dao.selectOneNotice(notice_num);
			if(nvo==null) {
				String message = "존재하지 않는 글입니다.";
				String loc = request.getContextPath()+"/service/board.do";
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			request.setAttribute("nvo", nvo);
			super.setViewPage("/WEB-INF/service/serviceCenterBoardUpdate.jsp");
		}
		
	}

}
