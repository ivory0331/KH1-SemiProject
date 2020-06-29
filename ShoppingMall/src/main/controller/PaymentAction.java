package main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import member.model.MemberVO;
import my.util.MyUtil;
import product.model.CartVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class PaymentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(!super.checkLogin(request)) {
			request.setAttribute("message", "주문서를 보려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", request.getContextPath()+"/member/login.do"); 
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		InterProductDAO pdao = new ProductDAO();
		InterIndexDAO idao = new IndexDAO();
		
		List<CartVO> cartList = pdao.selectProductCart(loginuser.getMember_num());
		
		HashMap<String, String> sumMap = pdao.selectSumCartPricePoint(loginuser.getMember_num());
		
		request.setAttribute("cartList", cartList);
		request.setAttribute("sumMap", sumMap);
		
		request.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
		
		Map<String, String> deliveryInfo = idao.orderHistoryFind(loginuser.getMember_num());
		
		if(deliveryInfo==null) {
			deliveryInfo = new HashMap<String, String>();
			deliveryInfo.put("recipient", loginuser.getName());
			deliveryInfo.put("recipient_mobile", loginuser.getMobile());
			deliveryInfo.put("recipient_postcode", loginuser.getPostcode());
			deliveryInfo.put("recipient_address", loginuser.getAddress());
			deliveryInfo.put("recipient_detailaddress", loginuser.getDetailAddress());
		}
		
		request.setAttribute("cartList", cartList);
		request.setAttribute("deliveryInfo", deliveryInfo);
		super.setViewPage("/WEB-INF/main/payment.jsp");

	}

}
