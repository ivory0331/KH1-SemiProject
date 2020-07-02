package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;

public class ReviewDelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String review_num = request.getParameter("review_num");
		InterIndexDAO dao = new IndexDAO();
		int result = dao.reviewDel(review_num);
		
		String message = "후기 삭제 도중 오류가 발생했습니다.";
		
		if(result != 0) {
			message = "후기가 삭제되었습니다.";
		}
				
		JSONObject obj = new JSONObject();
		obj.put("message", message);
		String json = obj.toString();
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
