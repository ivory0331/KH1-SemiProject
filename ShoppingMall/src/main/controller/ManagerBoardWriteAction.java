package main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.InterIndexDAO;
import member.model.MemberVO;
import my.util.MyUtil;
import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class ManagerBoardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser==null || loginuser.getStatus()!=2) {
			String message = "비정상적인 경로를 사용하여 접속하셨습니다. 돌아가세요";
			String loc = request.getContextPath()+"/index.do";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		if("get".equalsIgnoreCase(method)) {
			super.setViewPage("/WEB-INF/service/serviceCenterBoardWrite.jsp");
			return;
		}
		else {
			String subject = request.getParameter("title");
			String contents = request.getParameter("contents");
			String Qboard_category = request.getParameter("Qboard-categori");
			String boardType = request.getParameter("boardType");
			subject = MyUtil.replaceParameter(subject);
			contents = MyUtil.replaceParameter(contents);
			
			System.out.println("확인용:subject=>"+subject+"/contents=>"+contents+"/boardType=>"+boardType+"/Qboard_category=>"+Qboard_category);
		
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("subject", subject);
			paraMap.put("contents", contents);
			paraMap.put("boardType", boardType);
			paraMap.put("Qboard_category", Qboard_category);
			
			InterServiceDAO dao = new ServiceDAO();
			int n = dao.managerWrite(paraMap);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				if("board".equals(boardType)) {
					message = "공지사항 게시글을 작성했습니다.";
					loc=request.getContextPath()+"/service/board.do";
				}
				else {
					message = "자주하는 질문 게시글을 작성했습니다.";
					loc=request.getContextPath()+"/service/FAQ.do";
				}
			}
			else {
				message="게시글 작성 중에 오류가 발생했습니다.";
				loc = request.getContextPath()+"/index.do";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
	}

}
