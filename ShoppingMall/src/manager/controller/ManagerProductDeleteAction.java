package manager.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import manager.model.*;

public class ManagerProductDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] product_num = request.getParameterValues("product_num");
		
		InterProductDAO pdao = new ProductDAO();
						
		int sum=0;		
		for(int i=0; i<product_num.length; i++) {
				int n = pdao.productDelete(product_num[i]);
				sum+=n;			
		}
		
		if(sum==product_num.length) {
			
			 response.sendRedirect("managerProductList.do");

		}
				
	}

}
