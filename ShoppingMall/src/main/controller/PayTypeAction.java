package main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import member.model.MemberVO;
import product.model.CartVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class PayTypeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		System.out.println("확인용:pay.do method:"+method);
		if("get".equalsIgnoreCase(method)) { //결제 페이지(팝업창 이동)
			super.setRedirect(false);
			setViewPage("/WEB-INF/main/pay.jsp");
		}
		else { //결제 완료 후 DB 작업
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String selectDelivery = request.getParameter("selectDelivery");
			String mobile = String.join("", request.getParameterValues("mobile"));
			
			InterProductDAO pdao = new ProductDAO();
			InterIndexDAO idao = new IndexDAO();
			
			List<CartVO> cartList = pdao.selectProductCart(loginuser.getMember_num());
			Map<String, String> delivery = new HashMap<String, String>();
			if("1".equals(selectDelivery)) {
				delivery.put("postcode", request.getParameter("postcode"));
				delivery.put("mainAddress", request.getParameter("mainaddress"));
				delivery.put("subAddress", request.getParameter("subaddress"));
			}
			else {
				delivery.put("postcode", request.getParameter("newPostcode"));
				delivery.put("mainAddress", request.getParameter("newMainaddress"));
				delivery.put("subAddress", request.getParameter("newSubaddress"));
			}
			
			delivery.put("receiver", request.getParameter("nameReceiver"));
			delivery.put("reciverMobbile", mobile);
			delivery.put("totalPrice", request.getParameter("totalPrice"));
			delivery.put("deliveryMemo", request.getParameter("deliveryMemo"));
			
			int result = idao.order(loginuser, delivery, cartList);
			if(result == (3*cartList.size())+1) {
				session.setAttribute("payResult", result);
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/payment.do");
			}
		}
		
	}

}
