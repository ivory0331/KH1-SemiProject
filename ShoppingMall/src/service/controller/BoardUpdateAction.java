package service.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.NoticeVO;
import member.model.MemberVO;
import my.util.MyUtil;
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
		else {
			String subject = request.getParameter("title");
			String content = request.getParameter("contents");
			
			subject = MyUtil.replaceParameter(subject);
			content = MyUtil.replaceParameter(content);
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("subject", subject);
			paraMap.put("content", content);
			paraMap.put("notice_num", notice_num);
			
			InterServiceDAO dao = new ServiceDAO();
			int n = dao.boardUpdate(paraMap);
			
			if(n==1) {
				String message = "글이 수정되었습니다.";
				request.setAttribute("message", message);
				
			}else {
				String message = "글을 수정하는 도중 오류가 발생했습니다.";
				request.setAttribute("message", message);
			}
			String loc = request.getContextPath()+"/service/board.do";
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
