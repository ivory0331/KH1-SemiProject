package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.ProductVO;

public class DetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String idx = request.getParameter("idx");
		InterIndexDAO idao = new IndexDAO();
		ProductVO pvo = idao.productDetail(idx);
		if(pvo!=null) {
			request.setAttribute("product", pvo);
			super.setViewPage("/WEB-INF/main/detail.jsp");
		}
		else {
			System.out.println("에러~~~");
		}
		
		
	}

}
