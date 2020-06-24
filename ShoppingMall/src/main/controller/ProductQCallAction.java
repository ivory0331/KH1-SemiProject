package main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.ProductInquiryVO;


public class ProductQCallAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String product_num = request.getParameter("product_num");
		System.out.println("확인용=>product_num : "+product_num);
		InterIndexDAO dao = new IndexDAO();
		List<ProductInquiryVO> productQList = dao.productQCall(product_num);
		
		Gson gson = new Gson();
		String json = gson.toJson(productQList);
		
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
