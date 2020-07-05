package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.ProductVO;
import my.util.MyUtil;

public class DetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String idx = request.getParameter("product_num");
		InterIndexDAO idao = new IndexDAO();
		ProductVO pvo = idao.productDetail(idx);
		
		
		// URL창에서 상품 번호를 임의로 수정했을 경우 방지
		if(pvo!=null) { // 임의로 바꾼 번호의 상품이 있을 경우
			request.setAttribute("product", pvo);
			super.setViewPage("/WEB-INF/main/detail.jsp");
		}
		else { // 임의로 바꾼 번호의 상품이 없을 경우
			String message = "상품정보가 없습니다.";
			String loc = "javascript:history.back()";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
