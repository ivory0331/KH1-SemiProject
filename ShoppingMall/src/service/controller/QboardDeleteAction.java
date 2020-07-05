package service.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class QboardDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String faq_num = request.getParameter("faq_num");
		InterServiceDAO dao = new ServiceDAO();
		int result = dao.FAQDelete(faq_num);
		String message = "성공적으로 글을 삭제했습니다.";
		String loc=request.getContextPath()+"/service/FAQ.do";
		if(result==0) {
			message = "글을 삭제하는 도중 오류가 발생했습니다.";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		super.setViewPage("/WEB-INF/msg.jsp");
	}

}
