package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class BasketListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 장바구니 보기는 반드시 해당사용자가 로그인을 해야만 볼 수 있다.
		boolean loginFlag = super.checkLogin(request);
		
		if(!loginFlag) { // 로그인 상태가 아닌경우
			
			request.setAttribute("message", "장바구니를 보려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()"); 
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			// **** 페이징 처리 안한 상태로 장바구니 목록 보여주기 **** //
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			InterProductDAO pdao = new ProductDAO();
			
			List<CartVO> cartList = pdao.selectProductCart(loginuser.getMember_num());
			
			HashMap<String, String> sumMap = pdao.selectSumCartPricePoint(loginuser.getMember_num());
			
			request.setAttribute("cartList", cartList);
			request.setAttribute("sumMap", sumMap);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/main/shoppingCart.jsp");
		}
	}

}
