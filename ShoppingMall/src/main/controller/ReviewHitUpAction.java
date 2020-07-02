package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;

public class ReviewHitUpAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String review_num = request.getParameter("review_num");
		InterIndexDAO dao = new IndexDAO();
		int num = dao.reviewHitUp(review_num);
		
		JSONObject jobj = new JSONObject();
		jobj.put("review_num", num);
		String json = jobj.toString();
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
