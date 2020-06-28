package hyemin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import hyemin.model.InterReviewDAO;
import hyemin.model.ReviewDAO;

public class MyPageReviewDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			// GET 방식이라면
			
			String message = "비정상적인 경로로 들어왔습니다";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else if("POST".equalsIgnoreCase(method) && super.checkLogin(request)) {
			// POST 방식이고 로그인을 한 상태라면 
			
			String review_num = request.getParameter("review_num");  // ajax로 넘어온 data의 key값
	
			InterReviewDAO rdao = new ReviewDAO();
			
			// 특정 작성완료 후기 삭제하기
			int n = rdao.deleteReview(review_num);
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("n", n);
			
			String json = jsobj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");	

			
		} // end of else { POST 방식이라면 }---------------		

	}

}
