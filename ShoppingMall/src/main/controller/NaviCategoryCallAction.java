package main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;

public class NaviCategoryCallAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterIndexDAO dao = new IndexDAO();
		List<Map<String, String>> categoryList = dao.categoryCall();		
		
		Gson gson = new Gson();
		String json= gson.toJson(categoryList);
<<<<<<< HEAD
=======
		System.out.println("json:"+json);
>>>>>>> 7071bca5fc7ada42f6267a1c97b9b4b2490bd4e7
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
