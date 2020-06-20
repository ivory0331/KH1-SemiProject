package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO productdao = new ProductDAO();
		
	//	String fk_category_num = request.getParameter("fk_category_num");
	//	String fk_subcategory_num = request.getParameter("fk_subcategory_num");
		
		String fk_category_num = "4";
		String fk_subcategory_num = "41";
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_category_num", fk_category_num);
		paraMap.put("fk_subcategory_num", fk_subcategory_num);
		
		List<ProductVO> productList = productdao.selectProductList(paraMap);
		String categoryInfo = productdao.categoryInfo(fk_category_num);
		List<ProductVO> categoryList = productdao.categoryList(fk_category_num);
		
		
		request.setAttribute("productList", productList);
		request.setAttribute("categoryInfo", categoryInfo);
		request.setAttribute("categoryList", categoryList);
		
		super.setViewPage("/WEB-INF/main/productList.jsp");
		
	}

}
