package main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.InterProductDAO;
import main.model.ProductDAO;
import main.model.ProductVO;

public class ShoppingBasketAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		List<Map<String, String>> basket = (List<Map<String, String>>) session.getAttribute("basket");
		InterProductDAO dao = new ProductDAO();
		for(int i=0; i<basket.size(); i++) {
			ProductVO pvo = dao.productInfo(basket.get(i).get("product_num"));
		}
		
		super.setViewPage("/WEB-INF/main/shoppingBasket.jsp");
		
	}

}
