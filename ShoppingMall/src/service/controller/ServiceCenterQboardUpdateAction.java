package service.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.FAQtableVO;
import member.model.MemberVO;
import my.util.MyUtil;
import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class ServiceCenterQboardUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String faq_num = request.getParameter("faq_num");
		String method = request.getMethod();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null || loginuser.getStatus()!=2 ){
			String message = "비정상적인 방법으로 접속하셨습니다.";
			String loc = "javascript:history.back()";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		if("get".equalsIgnoreCase(method)) {
			InterServiceDAO dao = new ServiceDAO();
			FAQtableVO fvo = dao.selectOneFAQ(faq_num);
			request.setAttribute("fvo", fvo);
			super.setViewPage("/WEB-INF/service/serviceCenterQboardUpdate.jsp");
		}
		else {
			String subject = request.getParameter("title");
			String content = request.getParameter("contents");
			String category_num = request.getParameter("category_num");
			
			subject = MyUtil.replaceParameter(subject);
			content = MyUtil.replaceParameter(content);
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("subject", subject);
			paraMap.put("content", content);
			paraMap.put("faq_num", faq_num);
			paraMap.put("category_num",category_num);
			
			InterServiceDAO dao = new ServiceDAO();
			int n = dao.FAQUpdate(paraMap);
			
			if(n==1) {
				String message = "글이 수정되었습니다.";
				request.setAttribute("message", message);
				
			}else {
				String message = "글을 수정하는 도중 오류가 발생했습니다.";
				request.setAttribute("message", message);
			}
			String loc = request.getContextPath()+"/service/FAQ.do";
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
