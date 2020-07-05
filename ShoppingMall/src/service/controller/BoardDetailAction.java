package service.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.NoticeVO;
import member.model.MemberVO;
import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class BoardDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String notice_num = request.getParameter("notice_num");
		int hitUp = 0;
		
		InterServiceDAO dao = new ServiceDAO();
		List<NoticeVO> nvoList = dao.boardDetail(notice_num);
		if(nvoList.size()==0) {
			String message="존재하지 않는 글입니다.";
			String loc=request.getContextPath()+"/service/board.do";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser!=null && loginuser.getStatus()==1) {
			hitUp = dao.boardHitUp(notice_num);
		}
		
		request.setAttribute("nvoList", nvoList);
		request.setAttribute("size", nvoList.size());
		request.setAttribute("notice_num", notice_num);
		super.setViewPage("/WEB-INF/service/serviceCenterBoardDetail.jsp");
		
		
	}

}
