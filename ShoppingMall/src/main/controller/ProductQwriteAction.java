package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.ProductVO;
import member.model.MemberVO;

public class ProductQwriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String product_num = request.getParameter("product_num");
		System.out.println("확인용 => product_num:"+product_num);
		InterIndexDAO dao = new IndexDAO();
		ProductVO product = dao.productDetail(product_num);
		
		String message = "로그인이 필요한 기능입니다.";
		String loc = request.getContextPath()+"/member/login.do";
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		if(loginuser==null) {
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		
		if(product == null) {
			message = "등록된 상품이 없습니다.";
			loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			super.setViewPage("/WEB-INF/main/productQwrite.jsp");
		}
		
		
	}

}
