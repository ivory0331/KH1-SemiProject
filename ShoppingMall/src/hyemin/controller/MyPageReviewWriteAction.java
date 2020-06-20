package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import hyemin.model.InterReviewDAO;
import hyemin.model.ReviewDAO;
import hyemin.model.ReviewVO;

public class MyPageReviewWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
        //	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/myPageReviewWrite.jsp");
		}
		
		else {
			
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String image = request.getParameter("image");
			
			ReviewVO reviewvo = new ReviewVO();
			reviewvo.setSubject(subject);
			reviewvo.setContent(content);
			reviewvo.setImage(image);
			
			InterReviewDAO reviewdao = new ReviewDAO();
			int n = reviewdao.writeReview(reviewvo);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				message = "작성되었습니다.";
				loc = request.getContextPath()+"/member/myPageProductCompleteReview.do";
			}
			else {
				message = "작성에 실패했습니다.";
				loc = "javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
