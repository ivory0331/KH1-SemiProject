package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.InterProductDAO;
import manager.model.ProductDAO;
import member.model.MemberVO;
import product.model.ProductVO;

public class ManagerProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 1. 로그인 해야 가능		
		if(!super.checkLogin(request)) {
			
			 String message = "먼저 로그인 해야 가능합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	         return;
	         
		}
		//2. 관리자로 로그인 해야 가능
		else {
	    	 HttpSession session = request.getSession();
	    	 MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	         int status = loginuser.getStatus();
	         
	         if(status!=2) {
	            String message = "관리자만 접근이 가능합니다.";
	            String loc = "javascript:history.back()";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	            
	            return;
	         }
	         
	    }
		
		
		super.getCategoryList(request);
		
		String product_num = request.getParameter("product_num");
		
	    InterProductDAO pdao = new ProductDAO();
	    
	    ProductVO pvo = pdao.detailProduct(product_num);	    
	    pvo.setImageList(pdao.detailProductImg(product_num));
	    
	    request.setAttribute("pvo", pvo);

		super.setViewPage("/WEB-INF/manager/managerProductDetail.jsp");
		
		
		
	}

}
