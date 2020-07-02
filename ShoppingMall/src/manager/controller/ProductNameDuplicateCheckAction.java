package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import manager.model.*;

public class ProductNameDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String productNum = request.getParameter("productNum");
		String productName = request.getParameter("productName");
		InterProductDAO dao = new ProductDAO();
		boolean isUse = dao.productNameDuplicateCheck(productName,productNum);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("isUse", isUse);
		
		String json = jsonObj.toString();
		request.setAttribute("json",json);

		super.setViewPage("/WEB-INF/jsonview.jsp");		
		
	}

}
